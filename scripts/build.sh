#!/bin/bash
set -euo pipefail

# ==============================================================================
# Script de construcción de imágenes Docker con multi-stage y etiquetado semántico
# ==============================================================================
# Este script automatiza el proceso de build de imágenes Docker para el entorno
# de Fintech Innovations, soportando múltiples versiones y ambientes.
# ==============================================================================

# ------------------------------------------------------------------------------
# Configuración de variables de entorno
# ------------------------------------------------------------------------------
REGISTRY="${DOCKER_REGISTRY:-docker.io}"
IMAGE_NAME="${IMAGE_NAME:-fintech/app}"
DOCKERFILE_PATH="${DOCKERFILE_PATH:-./Dockerfile}"
CONTEXT_PATH="${CONTEXT_PATH:-.}"

# Versiones semánticas
MAJOR_VERSION="1"
MINOR_VERSION="0"
PATCH_VERSION="0"

# Ambiente de destino
TARGET_ENVIRONMENT="${TARGET_ENVIRONMENT:-staging}"

# Flags de configuración
PUSH_IMAGE="${PUSH_IMAGE:-true}"
USE_CACHE="${USE_CACHE:-true}"
PLATFORM="${PLATFORM:-linux/amd64}"

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

validate_environment() {
    log_info "Validando entorno de construcción..."

    if [[ ! -f "${DOCKERFILE_PATH}" ]]; then
        log_error "Dockerfile no encontrado en: ${DOCKERFILE_PATH}"
        exit 1
    fi

    if ! command -v docker &> /dev/null; then
        log_error "Docker no está instalado o no está en PATH"
        exit 1
    fi

    if ! docker version &> /dev/null; then
        log_error "Docker daemon no está ejecutándose"
        exit 1
    fi

    log_info "Validación de entorno completada exitosamente"
}

calculate_version() {
    local git_sha
    local version_string

    if command -v git &> /dev/null && [[ -d .git ]]; then
        git_sha=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
    else
        git_sha="noscm"
    fi

    version_string="${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}"
    echo "${version_string}-${git_sha}"
}

build_image() {
    local version_tag="$1"
    local additional_tags=("$2")
    local build_args=()
    local docker_args=()

    log_info "Iniciando construcción de imagen: ${IMAGE_NAME}:${version_tag}"

    # Agregar build args para versioning
    build_args+=(--build-arg "VERSION=${version_tag}")
    build_args+=(--build-arg "BUILD_DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ)")
    build_args+=(--build-arg "VCS_REF=$(git rev-parse HEAD 2>/dev/null || echo 'unknown')")

    # Configurar cache
    if [[ "${USE_CACHE}" == "true" ]]; then
        docker_args+=(--cache-from "${IMAGE_NAME}:latest")
    else
        docker_args+=(--no-cache)
    fi

    # Construir imagen
    docker build \
        "${build_args[@]}" \
        -t "${IMAGE_NAME}:${version_tag}" \
        -f "${DOCKERFILE_PATH}" \
        "${docker_args[@]}" \
        --platform "${PLATFORM}" \
        "${CONTEXT_PATH}"

    if [[ $? -ne 0 ]]; then
        log_error "Falló la construcción de la imagen"
        exit 1
    fi

    # Aplicar tags adicionales
    for tag in "${additional_tags[@]}"; do
        if [[ -n "${tag}" ]]; then
            docker tag "${IMAGE_NAME}:${version_tag}" "${IMAGE_NAME}:${tag}"
            log_info "Etiqueta adicional aplicada: ${IMAGE_NAME}:${tag}"
        fi
    done

    log_info "Construcción completada exitosamente"
}

push_image() {
    local version_tag="$1"

    log_info "Subiendo imagen: ${IMAGE_NAME}:${version_tag}"

    docker push "${IMAGE_NAME}:${version_tag}"

    if [[ $? -ne 0 ]]; then
        log_error "Falló la subida de la imagen"
        exit 1
    fi

    log_info "Imagen subida exitosamente"
}

scan_image() {
    local version_tag="$1"

    log_info "Escaneando imagen para vulnerabilidades: ${IMAGE_NAME}:${version_tag}"

    # Escaneo con Trivy si está disponible
    if command -v trivy &> /dev/null; then
        trivy image --severity HIGH,CRITICAL "${IMAGE_NAME}:${version_tag}" || {
            log_warning "El escaneo de Trivy encontró vulnerabilidades"
        }
    else
        log_warning "Trivy no está instalado, omitiendo escaneo de vulnerabilidades"
    fi

    # Escaneo con Checkov si está disponible (para Dockerfile)
    if command -v checkov &> /dev/null; then
        checkov -f "${DOCKERFILE_PATH}" || {
            log_warning "Checkov encontró problemas en el Dockerfile"
        }
    else
        log_warning "Checkov no está instalado, omitiendo escaneo de Dockerfile"
    fi

    log_info "Escaneo completado"
}

# ------------------------------------------------------------------------------
# Función principal
# ------------------------------------------------------------------------------

main() {
    log_info "=========================================="
    log_info "Iniciando proceso de build de contenedor"
    log_info "=========================================="

    validate_environment

    local version
    version=$(calculate_version)

    local full_image_tag="${version}-${TARGET_ENVIRONMENT}"

    # Construir imagen
    build_image "${full_image_tag}" "latest ${TARGET_ENVIRONMENT}"

    # Escanear imagen
    scan_image "${full_image_tag}"

    # Subir imagen si está habilitado
    if [[ "${PUSH_IMAGE}" == "true" ]]; then
        push_image "${full_image_tag}"
        push_image "latest"
        push_image "${TARGET_ENVIRONMENT}"
    fi

    log_info "=========================================="
    log_info "Proceso de build completado exitosamente"
    log_info "Imagen: ${IMAGE_NAME}:${full_image_tag}"
    log_info "=========================================="
}

# Ejecutar función principal
main "$@"