# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Optimización de la gestión de contenedores en un entorno de producción**.

| | |
|---|---|
| Tema | orquestación de contenedores |
| Nivel | senior-l2 |
| Chapter | DevSecOps |
| Especialidad | DevSecOps |
| Stack | YAML / Kubernetes |
| Patron arquitectonico | orquestación con Kubernetes (manifestos declarativos + operadores + HPA + service mesh) |
| Tiempo estimado | 20 horas |

## Receta del stack

Esqueleto obligatorio:

- `azure-pipelines.yml o .github/workflows/*.yml con stages reales`
- `Dockerfile multi-stage`
- `.dockerignore`
- `terraform/ con main.tf, variables.tf y outputs.tf`
- `terraform/environments/{env}/terraform.tfvars`
- `scripts/ con los scripts de build y healthcheck`
- `sonar-project.properties`

Trampas conocidas:

- `required_version` de Terraform va como RANGO (`>= 1.5`), nunca exacto: pineado, el proyecto no corre con otra version instalada.
- Los providers tambien con restriccion flexible (`~> 5.0`).
- El Dockerfile multi-stage necesita que la etapa final copie el artefacto de la etapa de build, no el codigo fuente.

Dependencias:

- hashicorp/kubernetes ~> 2.23
- hashicorp/aws ~> 5.31
- prometheus-community/helm-charts n/a
- grafana/grafana n/a
- Checkov n/a
- Trivy n/a
- kubectl 1.28.0
- helm 3.13.0

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Evaluación del sistema de orquestación existente**: Informe de evaluación del sistema de orquestación.
- **Fase 2 — Diseño de la estrategia de orquestación optimizada**: Documento de diseño de la estrategia de orquestación optimizada.
- **Fase 3 — Implementación y validación de la estrategia de orquestación**: Informe de validación de la estrategia de orquestación.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `k8s/manifests/app/deployment.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/app/hpa.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/app/service.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/app/configmap.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/app/secret.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/monitoring/prometheus.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/monitoring/grafana-dashboard.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/networking/ingress.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `k8s/manifests/networking/network-policy.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- [ ] `Dockerfile` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.

## Lo que falta y tenes que completar

### 1. Archivos que la arquitectura declara (3 de 21)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `terraform/outputs.tf`
- [ ] `terraform/environments/prod/terraform.tfvars`
- [ ] `k8s/manifests/monitoring/prometheus.yaml`

### Presentes (19)

- `providers.tf`
- `terraform/variables.tf`
- `terraform/main.tf`
- `terraform/environments/staging/terraform.tfvars`
- `k8s/manifests/app/deployment.yaml`
- `k8s/manifests/app/hpa.yaml`
- `k8s/manifests/app/service.yaml`
- `k8s/manifests/app/configmap.yaml`
- `k8s/manifests/app/secret.yaml`
- `k8s/manifests/monitoring/prometheus.yaml ---# Configuración de Prometheus para monitoreo del cluster y aplicaciones`
- `k8s/manifests/monitoring/grafana-dashboard.yaml`
- `k8s/manifests/networking/ingress.yaml`
- `k8s/manifests/networking/network-policy.yaml`
- `scripts/build.sh`
- `scripts/healthcheck.sh`
- `Dockerfile`
- `.dockerignore`
- `README.md`
- `.github/workflows/ci-cd.yml`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `terraform`
- `terraform/environments/prod`
- `terraform/environments/staging`
- `k8s`
- `k8s/manifests`
- `k8s/manifests/app`
- `k8s/manifests/monitoring`
- `k8s/manifests/networking`
- `scripts`
- `.github/workflows`

## Verificacion

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **orquestación con Kubernetes (manifestos declarativos + operadores + HPA + service mesh)**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter DevSecOps, Especialidad Ingeniería, Tecnología Orquestación de contenedores, Senior
- Brecha que el reto ataca: Tiene experiencia en al menos una plataforma de orquestación (Kubernetes, Openshift, Docker Swarm, Rancher, Mesos) que le permite administrar aplicaciones distribuidas en contenedores a gran escala. Además facilitando la gestión del ciclo de vida de los mismos apalancando las implementaciones DevOps
- Mision: Candidato con perfil Senior en DevSecOps, enfoque en Ingeniería

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
