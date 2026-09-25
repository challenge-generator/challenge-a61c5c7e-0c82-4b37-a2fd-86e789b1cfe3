#!/bin/bash
set -euo pipefail

# ==============================================================================
# Script de health check para validar disponibilidad de servicios dentro del pod
# ==============================================================================
# Este script implementa las verificaciones de salud requeridas por Kubernetes
# para determinar si un contenedor está listo para recibir tráfico y si está
# vivo para ser reiniciado si es necesario.
# ==============================================================================

# ------------------------------------------------------------------------------
# Configuración de variables de entorno
# ------------------------------------------------------------------------------
SERVICE_NAME="${SERVICE_NAME:-app}"
SERVICE_PORT="${SERVICE_PORT:-8080}"
HEALTH_ENDPOINT="${HEALTH_ENDPOINT:-/health}"
READY_ENDPOINT="${READY_ENDPOINT:-/ready}"
METRICS_ENDPOINT="${METRICS_ENDPOINT:-/metrics}"

# Tiempos de espera (en segundos)
STARTUP_TIMEOUT="${STARTUP_TIMEOUT:-60}"
LIVENESS_TIMEOUT="${LIVENESS_TIMEOUT:-30}"
READINESS_TIMEOUT="${READINESS_TIMEOUT:-10}"

# Configuración de reintentos
MAX_RETRIES="${MAX_RETRIES:-3}"
RETRY_DELAY="${RETRY_DELAY:-5}"

# Host y protocolo
HEALTH_HOST="${HEALTH_HOST:-localhost}"
USE_HTTPS="${USE_HTTPS:-false}"

# ------------------------------------------------------------------------------
# Funciones auxiliares
# ------------------------------------------------------------------------------

log_info() {
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] [INFO] $*"
}

log_error() {
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] [ERROR] $*" >&2
}

log_warning() {
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] [WARN] $*"
}

check_http_endpoint() {
    local endpoint="$1"
    local timeout="$2"
    local expected_status="$3"

    local scheme="http"
    if [[ "${USE_HTTPS}" == "true" ]]; then
        scheme="https"
    fi

    local url="${scheme}://${HEALTH_HOST}:${SERVICE_PORT}${endpoint}"

    if command -v curl &> /dev/null; then
        local status_code
        status_code=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout "${timeout}" --max-time "${timeout}" "${url}" 2>/dev/null || echo "000")

        if [[ "${status_code}" == "${expected_status}" ]]; then
            return 0
        else
            log_warning "Endpoint ${endpoint} devolvió código ${status_code}, esperado ${expected_status}"
            return 1
        fi
    elif command -v wget &> /dev/null; then
        local status_code
        status_code=$(wget -q -O /dev/null --server-response --timeout="${timeout}" "${url}" 2>&1 | awk '/HTTP\/1\.[01]/ {print $2}' | tail -n1 || echo "000")

        if [[ "${status_code}" == "${expected_status}" ]]; then
            return 0
        else
            log_warning "Endpoint ${endpoint} devolvió código ${status_code}, esperado ${expected_status}"
            return 1
        fi
    else
        log_error "Ni curl ni wget están disponibles para verificación HTTP"
        return 1
    fi
}

check_process() {
    local process_name="$1"

    if pgrep -x "${process_name}" > /dev/null; then
        return 0
    else
        log_warning "Proceso ${process_name} no encontrado"
        return 1
    fi
}

check_port_listening() {
    local port="$1"

    if command -v ss &> /dev/null; then
        if ss -tuln | grep -q ":${port} "; then
            return 0
        fi
    elif command -v netstat &> /dev/null; then
        if netstat -tuln | grep -q ":${port} "; then
            return 0
        fi
    elif command -v lsof &> /dev/null; then
        if lsof -i :"${port}" > /dev/null 2>&1; then
            return 0
        fi
    else
        # Método alternativo usando /dev/tcp
        if (echo >/dev/tcp/localhost/"${port}") 2>/dev/null; then
            return 0
        fi
    fi

    log_warning "Puerto ${port} no está escuchando"
    return 1
}

check_dependencies() {
    local dependencies="${DEPENDENCIES:-}"

    if [[ -z "${dependencies}" ]]; then
        return 0
    fi

    IFS=',' read -ra DEPS <<< "${dependencies}"
    for dep in "${DEPS[@]}"; do
        local dep_host dep_port
        IFS=':' read -ra DEP_INFO <<< "${dep}"
        dep_host="${DEP_INFO[0]}"
        dep_port="${DEP_INFO[1]:-5432}"

        if ! (echo >/dev/tcp/"${dep_host}"/"${dep_port}") 2>/dev/null; then
            log_warning "Dependencia no disponible: ${dep_host}:${dep_port}"
            return 1
        fi
    done

    return 0
}

check_memory_usage() {
    local max_percent="${MAX_MEMORY_PERCENT:-90}"

    if command -v free &> /dev/null; then
        local mem_available mem_total mem_used percent
        mem_available=$(free | awk '/Mem:/ {print $7}')
        mem_total=$(free | awk '/Mem:/ {print $2}')

        if [[ "${mem_total}" -gt 0 ]]; then
            mem_used=$((mem_total - mem_available))
            percent=$((mem_used * 100 / mem_total))

            if [[ "${percent}" -gt "${max_percent}" ]]; then
                log_warning "Uso de memoria alto: ${percent}% (límite: ${max_percent}%)"
                return 1
            fi
        fi
    fi

    return 0
}

check_disk_space() {
    local min_available_mb="${MIN_DISK_MB:-100}"

    if command -v df &> /dev/null; then
        local available_kb
        available_kb=$(df -BM / | awk 'NR==2 {print $4}' | tr -d 'M')

        if [[ "${available_kb}" -lt "${min_available_mb}" ]]; then
            log_warning "Espacio en disco bajo: ${available_kb}MB disponible"
            return 1
        fi
    fi

    return 0
}

# ------------------------------------------------------------------------------
# Verificaciones de Kubernetes
# ------------------------------------------------------------------------------

# Startup probe: verifica que la aplicación pueda iniciar
check_startup() {
    log_info "Ejecutando verificación de startup..."

    # Verificar que el proceso principal esté corriendo
    if ! check_process "${SERVICE_NAME}"; then
        log_error "Verificación de startup fallida: proceso no encontrado"
        return 1
    fi

    # Verificar que el puerto esté escuchando
    if ! check_port_listening "${SERVICE_PORT}"; then
        log_error "Verificación de startup fallida: puerto no escuchando"
        return 1
    fi

    # Verificar el endpoint de health
    if ! check_http_endpoint "${HEALTH_ENDPOINT}" "${STARTUP_TIMEOUT}" "200"; then
        log_error "Verificación de startup fallida: endpoint de health no responde"
        return 1
    fi

    log_info "Verificación de startup completada exitosamente"
    return 0
}

# Liveness probe: verifica que el contenedor esté vivo
check_liveness() {
    log_info "Ejecutando verificación de liveness..."

    # Verificar proceso principal
    if ! check_process "${SERVICE_NAME}"; then
        log_error "Verificación de liveness fallida: proceso no encontrado"
        return 1
    fi

    # Verificar puerto
    if ! check_port_listening "${SERVICE_PORT}"; then
        log_error "Verificación de liveness fallida: puerto no escuchando"
        return 1
    fi

    # Verificar endpoint de health
    if ! check_http_endpoint "${HEALTH_ENDPOINT}" "${LIVENESS_TIMEOUT}" "200"; then
        log_error "Verificación de liveness fallida: endpoint de health no responde"
        return 1
    fi

    # Verificar uso de memoria
    if ! check_memory_usage; then
        log_error "Verificación de liveness fallida: memoria excesiva"
        return 1
    fi

    # Verificar espacio en disco
    if ! check_disk_space; then
        log_error "Verificación de liveness fallida: disco lleno"
        return 1
    fi

    log_info "Verificación de liveness completada exitosamente"
    return 0
}

# Readiness probe: verifica que el contenedor esté listo para recibir tráfico
check_readiness() {
    log_info "Ejecutando verificación de readiness..."

    # Verificar endpoint de ready
    if ! check_http_endpoint "${READY_ENDPOINT}" "${READINESS_TIMEOUT}" "200"; then
        log_error "Verificación de readiness fallida: endpoint de ready no responde"
        return 1
    fi

    # Verificar dependencias externas
    if ! check_dependencies; then
        log_error "Verificación de readiness fallida: dependencias no disponibles"
        return 1
    fi

    # Verificar endpoint de métricas (opcional)
    if [[ -n "${METRICS_ENDPOINT}" ]]; then
        if ! check_http_endpoint "${METRICS_ENDPOINT}" "${READINESS_TIMEOUT}" "200"; then
            log_warning "Endpoint de métricas no disponible (no crítico)"
        fi
    fi

    log_info "Verificación de readiness completada exitosamente"
    return 0
}

# ------------------------------------------------------------------------------
# Función principal
# ------------------------------------------------------------------------------

main() {
    local check_type="${1:-startup}"

    case "${check_type}" in
        startup)
            check_startup
            ;;
        liveness)
            check_liveness
            ;;
        readiness)
            check_readiness
            ;;
        *)
            log_error "Tipo de verificación desconocido: ${check_type}"
            log_error "Tipos válidos: startup, liveness, readiness"
            exit 1
            ;;
    esac
}

main "$@"