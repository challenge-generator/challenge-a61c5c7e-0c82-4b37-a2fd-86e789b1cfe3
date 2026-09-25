# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `k8s/manifests/app/deployment.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/app/hpa.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/app/service.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/app/configmap.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/app/secret.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/monitoring/prometheus.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/monitoring/grafana-dashboard.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/networking/ingress.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `k8s/manifests/networking/network-policy.yaml` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.
- `Dockerfile` — El topic pide contenedores/orquestacion: este archivo es el ejercicio, no scaffolding.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `terraform/outputs.tf`
- `terraform/environments/prod/terraform.tfvars`
- `k8s/manifests/monitoring/prometheus.yaml`

## Como saber que terminaste

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter DevSecOps, Especialidad Ingeniería, Tecnología Orquestación de contenedores, Senior

### Brecha de conocimiento
Tiene experiencia en al menos una plataforma de orquestación (Kubernetes, Openshift, Docker Swarm, Rancher, Mesos) que le permite administrar aplicaciones distribuidas en contenedores a gran escala. Además facilitando la gestión del ciclo de vida de los mismos apalancando las implementaciones DevOps

### Misión / candidato
Candidato con perfil Senior en DevSecOps, enfoque en Ingeniería

### Reto
- Tema: orquestación de contenedores
- Seniority: senior-l2
- Tipo: practical
- Título: Optimización de la gestión de contenedores en un entorno de producción
- Tiempo estimado: 20 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Evaluación del sistema de orquestación existente — objetivo: Identificar las limitaciones y puntos de mejora en el sistema de orquestación actual. — entregable (NO resolver): Informe de evaluación del sistema de orquestación.
- Fase 2: Diseño de la estrategia de orquestación optimizada — objetivo: Proponer una estrategia de orquestación que aborde las limitaciones identificadas y mejore la eficiencia operativa. — entregable (NO resolver): Documento de diseño de la estrategia de orquestación optimizada.
- Fase 3: Implementación y validación de la estrategia de orquestación — objetivo: Implementar la estrategia de orquestación propuesta y validar su eficacia en un entorno de pruebas. — entregable (NO resolver): Informe de validación de la estrategia de orquestación.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: providers.tf ===
# Terraform providers configuration for Kubernetes and AWS
# Required for managing EKS clusters, IAM roles, and Kubernetes resources

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
    }
  }
}

# AWS Provider configuration
# Uses environment variables for credentials (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Kubernetes Provider configuration
# Authenticates using the EKS cluster endpoint and AWS IAM
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      module.eks.cluster_name
    ]
  }
}

# Helm Provider configuration
# Used for deploying Prometheus and Grafana via Helm charts
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        module.eks.cluster_name
      ]
    }
  }
}

# Data source for AWS caller identity
# Used to fetch the current AWS account ID for IAM policies

data "aws_caller_identity" "current" {}

# Data source for AWS availability zones
# Used to distribute resources across multiple AZs for high availability

data "aws_availability_zones" "available" {
  state = "available"
}

# IAM Policy for EKS cluster autoscaler
# Allows the cluster autoscaler to manage node groups

data "aws_iam_policy_document" "cluster_autoscaler" {
  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeInstanceTypes"
    ]
    resources = ["*"]
  }
}

# IAM Role for EKS cluster autoscaler
# Service account will assume this role

resource "aws_iam_role" "cluster_autoscaler" {
  name = "${var.project_name}-cluster-autoscaler-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = module.eks.oidc_provider_arn
        }
        Condition = {
          StringEquals = {
            "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:kube-system:cluster-autoscaler"
          }
        }
      }
    ]
  })
}

# IAM Policy attachment for cluster autoscaler
# Attaches the autoscaler policy to the role

resource "aws_iam_role_policy" "cluster_autoscaler" {
  name   = "${var.project_name}-cluster-autoscaler-policy"
  role   = aws_iam_role.cluster_autoscaler.id
  policy = data.aws_iam_policy_document.cluster_autoscaler.json
}

// === ARCHIVO: terraform/variables.tf ===
# Terraform variables declaration
# Centralized variable definitions for the entire infrastructure

variable "aws_region" {
  description = "AWS region where the resources will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (prod, staging, dev)"
  type        = string
  default     = "staging"
}

variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
  default     = "fintech-innovations"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "fintech-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.large"
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 10
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT gateway for private subnets"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Whether to use a single NAT gateway for all private subnets"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Whether to create a NAT gateway per availability zone"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Whether to automatically assign public IP to instances launched in public subnets"
  type        = bool
  default     = false
}

variable "prometheus_chart_version" {
  description = "Version of the Prometheus Helm chart to deploy"
  type        = string
  default     = "25.8.0"
}

variable "grafana_chart_version" {
  description = "Version of the Grafana Helm chart to deploy"
  type        = string
  default     = "6.61.0"
}

variable "prometheus_adapter_chart_version" {
  description = "Version of the Prometheus Adapter Helm chart to deploy"
  type        = string
  default     = "4.2.0"
}

variable "hpa_max_replicas" {
  description = "Maximum number of replicas for Horizontal Pod Autoscaler"
  type        = number
  default     = 20
}

variable "hpa_target_cpu_utilization" {
  description = "Target CPU utilization percentage for HPA"
  type        = number
  default     = 80
}

variable "hpa_target_requests_per_second" {
  description = "Target requests per second for custom metrics HPA"
  type        = number
  default     = 1000
}

variable "letsencrypt_email" {
  description = "Email address for Let's Encrypt certificate registration"
  type        = string
  default     = "devops@fintech-innovations.com"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "fintech-innovations.internal"
}

variable "cert_manager_chart_version" {
  description = "Version of the cert-manager Helm chart to deploy"
  type        = string
  default     = "v1.13.1"
}

variable "ingress_nginx_chart_version" {
  description = "Version of the ingress-nginx Helm chart to deploy"
  type        = string
  default     = "4.8.3"
}

variable "cluster_autoscaler_chart_version" {
  description = "Version of the cluster-autoscaler Helm chart to deploy"
  type        = string
  default     = "9.29.1"
}

// === ARCHIVO: terraform/main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
    kubernetes = {
n      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }

  backend "s3" {
    bucket = "fintech-innovations-terraform-state"
    key    = "prod/kubernetes-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "fintech-innovations"
      ManagedBy   = "terraform"
      CostCenter  = "devops"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, var.availability_zones_count)
  private_subnets = [for i in range(var.availability_zones_count) : cidrsubnet(var.vpc_cidr, 4, i)]
  public_subnets  = [for i in range(var.availability_zones_count) : cidrsubnet(var.vpc_cidr, 4, i + 100)]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    Name = "${var.cluster_name}-vpc"
    Type = "private"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = [var.node_instance_type]
  }

  eks_managed_node_groups = {
    primary = {
      name = "${var.cluster_name}-nodes"

      instance_types = [var.node_instance_type]

      min_size     = var.node_group_min_size
      max_size     = var.node_group_max_size
      desired_size = var.node_group_desired_size

      capacity_type = "ON_DEMAND"

      labels = {
        "node-group" = "primary"
        "workload"   = "application"
      }

      tags = {
        "k8s.amazonaws.com/managed" = "true"
        "k8s.amazonaws.com/nodegroup" = "primary"
      }
    }

    spot = {
      name = "${var.cluster_name}-nodes-spot"

      instance_types = ["m5.large", "m5.xlarge", "m5.2xlarge", "m4.xlarge"]

      min_size     = var.node_group_min_size
      max_size     = var.node_group_max_size
      desired_size = var.node_group_desired_size

      capacity_type = "SPOT"

      labels = {
        "node-group"   = "spot"
        "workload"     = "batch"
        "capacity-type" = "spot"
      }

      taints = [
        {
          key    = "workload"
          value  = "batch"
          effect = "NO_SCHEDULE"
        }
      ]
    }
  }

  tags = var.common_tags
}

resource "aws_iam_role_policy" "ebs_csi_driver" {
  name = "${var.cluster_name}-ebs-csi-driver-policy"
  role = module.eks.node_group_iam_role_arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:AttachVolume",
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:DeleteSnapshot",
          "ec2:DeleteVolume",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumeAttributes"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "alb_controller" {
  name = "${var.cluster_name}-alb-controller-policy"
  role = module.eks.node_group_iam_role_arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "acm:DescribeCertificate",
          "acm:ListCertificates",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateSecurityGroup",
          "ec2:CreateTags",
          "ec2:DeleteSecurityGroup",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "elasticloadbalancing:AddTags",
          "elasticloadbalancing:CreateListener",
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:CreateRule",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:DeleteListener",
          "elasticloadbalancing:DeleteLoadBalancer",
          "elasticloadbalancing:DeleteRule",
          "elasticloadbalancing:DeleteTargetGroup",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeRules",
          "elasticloadbalancing:DescribeTags",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:ModifyListener",
          "elasticloadbalancing:ModifyRule",
          "elasticloadbalancing:ModifyTargetGroup",
          "elasticloadbalancing:RegisterTargets",
          "elasticloadbalancing:DeregisterTargets",
          "iam:CreateServiceLinkedRole",
          "cognito-idp:DescribeUserPoolClient",
          "wafv2:GetWebACL",
          "wafv2:GetWebACLForResource",
          "wafv2:ListResourcesForWebACL",
          "wafv2:ListWebACLs",
          "tag:GetResources",
          "tag:TagResources"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:CreateServiceLinkedRole"
        ]
        Resource = "*"
        Condition = {
          StringLike = {
            "iam:AWSServiceName" = "elasticloadbalancing.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.11.0"

  set {
    name  = "apiService.insecureSkipVerify"
    value = "true"
  }
}

resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler-chart"
  namespace  = "kube-system"
  version    = "9.34.1"

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "rbac.serviceAccount.namespace"
    value = "kube-system"
  }
}

resource "helm_release" "prometheus" {
  count = var.enable_monitoring ? 1 : 0

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "monitoring"
  version    = "25.8.0"

  set {
    name  = "server.persistentVolume.size"
    value = "50Gi"
  }

  set {
    name  = "server.retention"
    value = "30d"
  }

  set {
    name  = "alertmanager.persistentVolume.size"
    value = "10Gi"
  }

  set {
    name  = "pushgateway.persistentVolume.size"
    value = "2Gi"
  }

  set {
    name  = "kubeStateMetrics.enabled"
    value = "true"
  }

  set {
    name  = "nodeExporter.enabled"
    value = "true"
  }
}

resource "helm_release" "grafana" {
  count = var.enable_monitoring ? 1 : 0

  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"
  version    = "6.58.0"

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  set {
    name  = "adminPassword"
    value = "${var.grafana_admin_password}"
  }

  set {
    name  = "datasources.datasources\.yaml.datasources[0].name"
    value = "Prometheus"
  }

  set {
    name  = "datasources.datasources\.yaml.datasources[0].type"
    value = "prometheus"
  }

  set {
    name  = "datasources.datasources\.yaml.datasources[0].url"
    value = "http://prometheus-server.monitoring.svc.cluster.local:9090"
  }

  set {
    name  = "datasources.datasources\.yaml.datasources[0].access"
    value = "proxy"
  }

  set {
    name  = "datasources.datasources\.yaml.datasources[0].isDefault"
    value = "true"
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  version    = "4.8.0"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.annotations.service\.beta\.kubernetes\.io/aws-load-balancer-type"
    value = "nlb"
  }

  set {
    name  = "controller.service.annotations.service\.beta\.kubernetes\.io/aws-load-balancer-ssl-cert"
    value = "${var.acm_certificate_arn}"
  }

  set {
    name  = "controller.service.annotations.service\.beta\.kubernetes\.io/aws-load-balancer-ssl-negotiation-policy"
    value = "ELBSecurityPolicy-TLS-1-2-2017-01"
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }

  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = "true"
  }

  set {
    name  = "controller.metrics.serviceMonitor.additionalLabels.release"
    value = "prometheus"
  }

  set {
    name  = "controller.replicaCount"
    value = var.ingress_replica_count
  }
}

resource "kubernetes_namespace" "app" {
  metadata {
    name = "application"

    labels = {
      "name"                                      = "application"
      "environment"                               = var.environment
      "pod-security.kubernetes.io/enforce"       = "restricted"
      "pod-security.kubernetes.io/audit"          = "restricted"
      "pod-security.kubernetes.io/warn"           = "restricted"
    }
  }
}

resource "kubernetes_namespace" "monitoring" {
  count = var.enable_monitoring ? 1 : 0

  metadata {
    name = "monitoring"

    labels = {
      "name"       = "monitoring"
      "environment" = var.environment
    }
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"

    labels = {
      "name"                                      = "ingress-nginx"
      "environment"                               = var.environment
      "pod-security.kubernetes.io/enforce"       = "restricted"
      "pod-security.kubernetes.io/audit"          = "restricted"
      "pod-security.kubernetes.io/warn"           = "restricted"
    }
  }
}

resource "kubernetes_config_map" "cluster_config" {
  metadata {
    name      = "cluster-config"
    namespace = "kube-system"
  }

  data = {
    "cluster-name"    = var.cluster_name
    "environment"     = var.environment
    "aws-region"      = var.aws_region
    "kubernetes-version" = var.kubernetes_version
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${var.cluster_name}-logs-${var.aws_region}"

  tags = {
    Name        = "${var.cluster_name}-logs"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_lb_target_group" "app" {
  name     = "${var.cluster_name}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "app" {
  name               = "${var.cluster_name}-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.vpc.default_security_group]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name = "${var.cluster_name}-app-alb"
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_lb_listener_rule" "app" {
  listener_arn = aws_lb_listener.app.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_security_group" "app" {
  name        = "${var.cluster_name}-app-sg"
  description = "Security group for application pods"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow all traffic from VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name        = "${var.cluster_name}-app-sg"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "app_workload" {
  name = "${var.cluster_name}-app-workload-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::fintech-innovations-app-data/*"
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:fintech-app-*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:fintech-app/*"
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

resource "random_id" "suffix" {
  byte_length = 8
}

output "cluster_name" {
  description = "Nombre del cluster EKS"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint del API server de Kubernetes"
  value       = module.eks.cluster_endpoint
}

output "cluster_arn" {
  description = "ARN del cluster EKS"
  value       = module.eks.cluster_arn
}

output "node_role_arn" {
  description = "ARN del rol IAM de los nodos"
  value       = module.eks.node_group_iam_role_arn
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = module.vpc.public_subnet_ids
}

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = aws_lb.app.arn
}

output "alb_dns_name" {
  description = "DNS name del ALB"
  value       = aws_lb.app.dns_name
}

output "logs_bucket_name" {
  description = "Nombre del bucket de logs"
  value       = aws_s3_bucket.logs.id
}

output "app_security_group_id" {
  description = "ID del security group de la aplicación"
  value       = aws_security_group.app.id
}

output "grafana_url" {
  description = "URL de Grafana"
  value       = var.enable_monitoring ? "http://grafana.${var.cluster_name}.fintech-innovations.com" : "monitoring disabled"
}

output "prometheus_url" {
  description = "URL de Prometheus"
  value       = var.enable_monitoring ? "http://prometheus.${var.cluster_name}.fintech-innovations.com" : "monitoring disabled"
}

output "kubectl_config_command" {
  description = "Comando para configurar kubectl"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}

output "cluster_ca_cert" {
  description = "Certificado CA del cluster"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "cluster_oidc_issuer" {
  description = "OIDC Issuer del cluster"
  value       = module.eks.cluster_oidc_issuer
}

output "app_namespace" {
  description = "Namespace de la aplicación"
  value       = kubernetes_namespace.app.metadata[0].name
}

output "ingress_namespace" {
  description = "Namespace del ingress controller"
  value       = kubernetes_namespace.ingress_nginx.metadata[0].name
}

output "monitoring_namespace" {
  description = "Namespace de monitoring"
  value       = var.enable_monitoring ? kubernetes_namespace.monitoring[0].metadata[0].name : "monitoring disabled"
}

output "nodes_min_count" {
  description = "Cantidad mínima de nodos"
  value       = var.node_group_min_size
}

output "nodes_max_count" {
  description = "Cantidad máxima de nodos"
  value       = var.node_group_max_size
}

output "nodes_desired_count" {
  description = "Cantidad deseada de nodos"
  value       = var.node_group_desired_size
}

output "kubernetes_version" {
  description = "Versión de Kubernetes"
  value       = var.kubernetes_version
}

output "environment" {
  description = "Ambiente de despliegue"
  value       = var.environment
}

output "aws_region" {
  description = "Región de AWS"
  value       = var.aws_region
}

output "enable_monitoring" {
  description = "Flag de monitoreo habilitado"
  value       = var.enable_monitoring
}

output "enable_deletion_protection" {
  description = "Flag de protección contra eliminación"
  value       = var.enable_deletion_protection
}


// === ARCHIVO: terraform/environments/staging/terraform.tfvars ===
# Configuración específica del ambiente de staging para el cluster EKS
# Fintech Innovations - Optimización de Orquestación de Contenedores
#
# Este archivo define los valores específicos para el entorno de staging.
# Los valores aquí definidos son diferentes a producción para permitir
# pruebas controladas antes de desplegar a producción.

# =============================================================================
# CONFIGURACIÓN DEL CLUSTER EKS
# =============================================================================

cluster_name                = "fintech-eks-staging"
cluster_version             = "1.28"
cluster_endpoint_public     = true
cluster_endpoint_private    = true
cluster_endpoint_public_cidrs = ["0.0.0.0/0"]
cluster_log_types           = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

# =============================================================================
# CONFIGURACIÓN DE NODOS Y CAPACIDAD
# =============================================================================

# Nodos Managed Node Group - Configuración para staging
# Staging usa menor capacidad que producción para optimizar costos
node_groups = {
  general = {
    instance_types      = ["t3.medium"]
    min_size            = 2
    max_size            = 8
    desired_capacity    = 3
    capacity_type       = "ON_DEMAND"
    disk_size           = 50
    labels = {
      environment       = "staging"
      workload-type     = "general"
      node-group        = "general"
    }
    taints = []
    tags = {
      Environment        = "staging"
      NodeGroup          = "general"
      CostCenter         = "fintech-staging"
    }
  },
  workloads = {
    instance_types      = ["t3.large"]
    min_size            = 1
    max_size            = 4
    desired_capacity    = 2
    capacity_type       = "ON_DEMAND"
    disk_size           = 100
    labels = {
      environment       = "staging"
      workload-type     = "compute-intensive"
      node-group        = "workloads"
    }
    taints = [
      {
        key    = "workload-type"
        value  = "compute-intensive"
        effect = "NO_SCHEDULE"
      }
    ]
    tags = {
      Environment        = "staging"
      NodeGroup          = "workloads"
      CostCenter         = "fintech-staging"
    }
  }
}

# =============================================================================
# CONFIGURACIÓN DE ESCALADO AUTOMÁTICO (HPA)
# =============================================================================

# Parámetros de autoscaling para el cluster
autoscaling = {
  # Configuración global de Cluster Autoscaler
  cluster_autoscaler = {
    enable                = true
    scale_down_enabled    = true
    scale_down_delay      = "10m"
    scale_down_unneeded   = "10m"
    scale_down_unready    = "20m"
    skip_nodes_with_local_storage = true
    skip_nodes_with_system_pods   = true
  }

  # Políticas de escalado horizontal de pods (HPA)
  hpa_defaults = {
    min_replicas         = 2
    max_replicas         = 10
    target_cpu_utilization = 70
    target_memory_utilization = 80
    scale_up_stabilization = "0s"
    scale_down_stabilization = "5m"
  }

  # Configuración de métricas personalizadas para escalado
  custom_metrics = {
    requests_per_second = {
      metric_name     = "http_requests_per_second"
      target_value    = 1000
      target_type     = "AverageValue"
      scale_up_threshold  = 800
      scale_down_threshold = 200
    }
    queue_depth = {
      metric_name     = "queue_messages_pending"
      target_value    = 100
      target_type     = "AverageValue"
      scale_up_threshold  = 80
      scale_down_threshold = 20
    }
  }

  # Configuración de timeout para modo falla
  failure_mode = {
    timeout_seconds        = 5
    fallback_replicas      = 3
    circuit_breaker_enable = true
    circuit_breaker_threshold = 3
  }
}

# =============================================================================
# POLÍTICAS IAM PARA ROLES DE KUBERNETES
# =============================================================================

# Políticas IAM para el nodo worker - staging
node_iam_policies = {
  # Política base para todos los nodos
  base = {
    policy_name = "FintechStagingNodeBasePolicy"
    statements = [
      {
        sid    = "EC2ContainerRegistryPull"
        effect = "Allow"
        actions = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken",
          "ecr:GetDownloadUrlForLayer"
        ]
        resources = ["*"]
      },
      {
        sid    = "S3ReadAccess"
        effect = "Allow"
        actions = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        resources = [
          "arn:aws:s3:::fintech-staging-assets",
          "arn:aws:s3:::fintech-staging-assets/*"
        ]
      },
      {
        sid    = "CloudWatchLogs"
        effect = "Allow"
        actions = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        resources = ["arn:aws:logs:*:*:log-group:/aws/eks/fintech-eks-staging*"]
      }
    ]
  }

  # Políticas específicas para métricas y monitoreo
  monitoring = {
    policy_name = "FintechStagingMonitoringPolicy"
    statements = [
      {
        sid    = "PrometheusMetrics"
        effect = "Allow"
        actions = [
          "prometheus:ListWorkspaces",
          "prometheus:DescribeWorkspace"
        ]
        resources = ["*"]
      },
      {
        sid    = "CloudWatchMetrics"
        effect = "Allow"
        actions = [
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricStatistics"
        ]
        resources = ["*"]
      }
    ]
  }
}

# Política IRSA (IAM Roles for Service Accounts) para aplicaciones
irsa_policies = {
  # Service Account para aplicación principal
  app_service_account = {
    namespace           = "fintech-app"
    service_accountname = "fintech-app-sa"
    policy_name         = "FintechStagingAppSAPolicy"
    permissions = {
      dynamodb = {
        tables     = ["fintech-staging-users", "fintech-staging-transactions"]
        actions    = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:Query", "dynamodb:Scan"]
      }
      s3 = {
        buckets    = ["fintech-staging-reports", "fintech-staging-exports"]
        actions    = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
      }
      secrets = {
        secrets    = ["fintech/staging/db-credentials", "fintech/staging/api-keys"]
        actions    = ["secretsmanager:GetSecretValue"]
      }
    }
  }

  # Service Account para métricas personalizadas
  metrics_adapter = {
    namespace           = "monitoring"
    service_accountname = "prometheus-adapter-sa"
    policy_name         = "FintechStagingMetricsPolicy"
    permissions = {
      cloudwatch = {
        actions = [
          "cloudwatch:GetMetricData",
          "cloudwatch:ListMetrics"
        ]
        resources = ["*"]
      }
    }
  }
}

# =============================================================================
# CONFIGURACIÓN DE RED Y SEGURIDAD
# =============================================================================

vpc_configuration = {
  # Staging usa VPC existente o compartida
  use_existing_vpc    = true
  vpc_id              = "vpc-staging-shared"
  private_subnet_ids  = ["subnet-staging-private-1a", "subnet-staging-private-1b", "subnet-staging-private-1c"]
  public_subnet_ids   = ["subnet-staging-public-1a", "subnet-staging-public-1b"]
  
  # Configuración de seguridad
  security_groups = {
    cluster_sg     = "sg-eks-cluster-staging"
    node_sg        = "sg-eks-nodes-staging"
    app_sg         = "sg-fintech-app-staging"
    database_sg    = "sg-fintech-db-staging"
  }

  # Calculo de CIDR para pods (CNI)
  pod_cidr           = "10.244.0.0/16"
  service_cidr       = "10.96.0.0/16"
  cluster_dns        = "cluster.local"
}

# =============================================================================
# CONFIGURACIÓN DE ALMACENAMIENTO
# =============================================================================

storage_configuration = {
  # StorageClass para diferentes tipos de almacenamiento
  storage_classes = {
    standard = {
      type                = "gp3"
      provisioner         = "ebs.csi.aws.com"
      reclaim_policy      = "Delete"
      allow_volume_expansion = true
      volume_binding_mode = "WaitForFirstConsumer"
    },
    fast = {
      type                = "io2"
      provisioner         = "ebs.csi.aws.com"
      reclaim_policy      = "Delete"
      allow_volume_expansion = true
      volume_binding_mode = "Immediate"
      iops_per_gb         = 10
    },
    shared = {
      type                = "efs"
      provisioner         = "efs.csi.aws.com"
      reclaim_policy      = "Retain"
      volume_binding_mode = "Immediate"
    }
  }

  # Configuración de PersistentVolumeClaim por defecto
  default_pvc = {
    storage_request   = "10Gi"
    storage_class     = "standard"
    access_modes      = ["ReadWriteOnce"]
  }
}

# =============================================================================
# CONFIGURACIÓN DE MONITOREO Y OBSERVABILIDAD
# =============================================================================

monitoring_config = {
  # Prometheus - Configuración de scraping
  prometheus = {
    enabled              = true
    retention            = "15d"
    storage_size         = "50Gi"
    retention_size       = "40Gi"
    scrape_interval      = "30s"
    evaluation_interval  = "30s"
    
    # Targets de scraping específicos para staging
    scrape_configs = {
      kubernetes_apiserver = true
      kubernetes_nodes     = true
      kubernetes_pods      = true
      application_metrics  = true
      node_exporter        = true
      kube_state_metrics   = true
    }
  }

  # Grafana - Dashboards y alertas
  grafana = {
    enabled              = true
    admin_password       = ""  # Gestionado externamente via AWS Secrets Manager
    persistence_enabled  = true
    persistence_size     = "10Gi"
    
    # Dashboards incluidos
    default_dashboards = [
      "kubernetes-cluster-overview",
      "kubernetes-pod-overview",
      "kubernetes-node-resources",
      "application-performance",
      "fintech-transactions"
    ]

    # Configuración de alertas
    alerting = {
      enabled                    = true
      notification_channels      = ["staging-alerts"]
      group_wait                 = "10s"
      group_interval             = "5m"
      repeat_interval            = "4h"
    }
  }

  # Alertas específicas para staging
  alerting_rules = {
    high_cpu_usage = {
      threshold    = 80
      duration     = "5m"
      severity     = "warning"
    }
    high_memory_usage = {
      threshold    = 85
      duration     = "5m"
      severity     = "warning"
    }
    pod_restarts = {
      threshold    = 5
      duration     = "5m"
      severity     = "critical"
    }
    high_request_rate = {
      threshold    = 900
      duration     = "2m"
      severity     = "warning"
      action       = "scale_up"
    }
    timeout_errors = {
      threshold    = 10
      duration     = "1m"
      severity     = "critical"
      action       = "alert"
    }
  }
}

# =============================================================================
# CONFIGURACIÓN DE CERTIFICADOS Y TLS
# =============================================================================

tls_configuration = {
  # cert-manager para TLS automático
  cert_manager = {
    enabled                  = true
    letsencrypt_environment  = "staging"
    
    # Certificado para el dominio de staging
    certificates = [
      {
        name         = "fintech-staging-tls"
        dns_names    = ["staging.fintech-innovations.com", "*.staging.fintech-innovations.com"]
        issuer       = "letsencrypt-prod"
        secret_name  = "fintech-staging-tls"
      }
    ]
  }
}

# =============================================================================
# CONFIGURACIÓN DE DESPLIEGUE Y ESTRATEGIAS
# =============================================================================

deployment_strategy = {
  # Estrategia de despliegue para staging
  # Staging usa RollingUpdate con configuración de prueba
  default = {
    type                 = "RollingUpdate"
    max_surge            = 1
    max_unavailable      = 0
    progress_deadline    = 600
    min_ready_seconds    = 30
  }

  # Estrategias específicas por aplicación
  strategies = {
    fintech-api = {
      type                 = "Canary"
      canary_percentage    = 20
      canary_steps         = 3
      analysis_interval    = "2m"
    },
    fintech-frontend = {
      type                 = "RollingUpdate"
      max_surge            = 2
      max_unavailable      = 1
    }
  }

  # Configuración de salud (readiness/liveness)
  health_checks = {
    readiness_probe = {
      initial_delay_seconds = 10
      period_seconds        = 10
      timeout_seconds       = 5
      success_threshold     = 1
      failure_threshold     = 3
    }
    liveness_probe = {
      initial_delay_seconds = 30
      period_seconds        = 20
      timeout_seconds       = 5
      success_threshold     = 1
      failure_threshold     = 3
    }
    startup_probe = {
      initial_delay_seconds = 0
      period_seconds        = 10
      timeout_seconds       = 5
      failure_threshold     = 30
    }
  }
}

# =============================================================================
# CONFIGURACIÓN DE RECURSOS DE APLICACIÓN
# =============================================================================

resource_quotas = {
  # Límites de recursos por namespace en staging
  namespaces = {
    "fintech-app" = {
      requests_cpu          = "4"
      limits_cpu            = "8"
      requests_memory       = "8Gi"
      limits_memory         = "16Gi"
      pods                  = "20"
      services              = "10"
      secrets               = "20"
      configmaps            = "20"
    },
    "fintech-worker" = {
      requests_cpu          = "2"
      limits_cpu            = "4"
      requests_memory       = "4Gi"
      limits_memory         = "8Gi"
      pods                  = "10"
      jobs                  = "5"
    },
    "monitoring" = {
      requests_cpu          = "2"
      limits_cpu            = "4"
      requests_memory       = "4Gi"
      limits_memory         = "8Gi"
      pods                  = "15"
    }
  }

  # Límites de recursos por contenedor (default)
  container_defaults = {
    requests_cpu      = "100m"
    limits_cpu        = "500m"
    requests_memory   = "256Mi"
    limits_memory     = "512Mi"
  }
}

# =============================================================================
# CONFIGURACIÓN DE BACKUP Y RECUPERACIÓN
# =============================================================================

backup_configuration = {
  # Configuración de Velero para backups
  velero = {
    enabled              = true
    schedule             = "0 2 * * *"  # Daily a las 2AM
    ttl                  = "720h"  # 30 días
    include_cluster      = true
    
    # Volúmenes a respaldar
    included_volumes = ["standard", "fast"]
    excluded_volumes = ["shared"]

    # Buckets de backup
    backup_storage_location = "s3://fintech-staging-backups"
  }

  # Retención de logs
  log_retention = {
    application_logs = "15d"
    audit_logs       = "90d"
    access_logs      = "30d"
  }
}

# =============================================================================
# CONFIGURACIÓN DE COSTOS Y OPTIMIZACIÓN
# =============================================================================

cost_optimization = {
  # Configuración de Spot para cargas de trabajo tolerantes
  spot_instances = {
    enabled              = false  # Staging no usa spot por defecto para estabilidad
    fallback_to_od       = true
  }

  # Configuración de Savings Plans
  savings_plan = {
    compute_savings_plan = false  # No aplica en staging
  }

  # Políticas de limpieza
  cleanup_policies = {
    untagged_resources   = true
    old_images           = true
    unused_volumes       = true
    completed_jobs       = true
    completed_jobs_ttl   = "24h"
  }

  # Alertas de costo
  cost_alerts = {
    enabled              = true
    daily_budget         = 50  # USD
    alert_threshold      = 80  # Porcentaje del presupuesto
  }
}

# =============================================================================
# CONFIGURACIÓN DE INTEGRACIÓN EXTERNA
# =============================================================================

external_integrations = {
  # GitHub Actions (si se usa para despliegues)
  github = {
    enabled              = true
    repository           = "fintech-innovations/container-orchestration"
    environment          = "staging"
    required_reviewers   = 1
  }

  # Sistemas de monitoreo externos
  external_monitoring = {
    datadog = {
      enabled            = false
      api_key_secret     = "datadog-api-key"
    }
    newrelic = {
      enabled            = false
      license_key_secret = "newrelic-license-key"
    }
  }

  # Notificaciones
  notifications = {
    slack = {
      enabled            = true
      webhook_secret     = "slack-webhook-staging"
      channel            = "#fintech-staging-alerts"
      notify_on = [
        "deployment_failure",
        "high_cpu",
        "high_memory",
        "pod_crash",
        "scaling_events"
      ]
    }
    email = {
      enabled            = true
      recipients         = ["devops-staging@fintech-innovations.com"]
      notify_on = [
        "deployment_failure",
        "critical_alerts"
      ]
    }
  }
}

# =============================================================================
# VARIABLES DE ENTORNO PARA APLICACIONES
# =============================================================================

application_environment = {
  # Variables globales para todas las aplicaciones
  global = {
    ENVIRONMENT        = "staging"
    LOG_LEVEL          = "debug"
    ENABLE_DEBUG       = "true"
    METRICS_ENABLED    = "true"
    TRACE_ENABLED      = "true"
    CACHE_TTL          = "300"
    SESSION_TIMEOUT    = "1800"
  }

  # Variables específicas por aplicación
  fintech_api = {
    DATABASE_HOST       = "{{ .Values.database.host }}"
    DATABASE_PORT       = "5432"
    DATABASE_NAME       = "fintech_staging"
    REDIS_URL           = "redis://fintech-staging-redis:6379"
    API_RATE_LIMIT      = "1000"
    EXTERNAL_API_URL    = "https://api-staging.fintech-innovations.com"
  }

  fintech_frontend = {
    API_ENDPOINT       = "https://api.staging.fintech-innovations.com"
    CDN_URL            = "https://cdn.staging.fintech-innovations.com"
    ANALYTICS_ID       = "UA-XXXXXXXXX-2"
  }
}

# =============================================================================
# POLÍTICAS DE SEGURIDAD ADICIONALES
# =============================================================================

security_policies = {
  # Network Policies
  network_policies = {
    default_deny_ingress = true
    default_deny_egress  = false
    allow_dns            = true
    allow_api_server     = true
  }

  # Pod Security Standards
  pss = {
    enforce            = "baseline"
    audit              = "restricted"
  }

  # Políticas de seguridad personalizadas
  custom_policies = {
    disallow_privileged   = true
    disallow_host_path    = true
    require_run_as_non_root = false  # Staging más permisivo
    require_seccomp       = false
    allow_privilege_escalation = false
  }

  # Scan de vulnerabilidades
  vulnerability_scan = {
    enabled              = true
    schedule             = "0 3 * * *"  # Daily a las 3AM
    severity_threshold   = "HIGH"
    ignore_unfixed       = false
  }
}

// === ARCHIVO: k8s/manifests/app/deployment.yaml ===
apiVersion: apps/v1
kind: Deployment
metadata:
  name: fintech-app
  namespace: fintech-prod
  labels:
    app: fintech-app
    tier: application
    environment: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: fintech-app
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: fintech-app
        tier: application
        environment: production
    spec:
      containers:
      - name: fintech-app-container
        image: fintech Innovations.azurecr.io/fintech-app:latest
        ports:
        - containerPort: 8080
          protocol: TCP
        env:
        - name: ENVIRONMENT
          value: "production"
        - name: LOG_LEVEL
          value: "info"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health/live
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
        startupProbe:
          httpGet:
            path: /health/startup
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 30
      serviceAccountName: fintech-app-sa
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        fsGroup: 1000
---
// === ARCHIVO: k8s/manifests/app/hpa.yaml ===
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: fintech-app-hpa
  namespace: fintech-prod
  labels:
    app: fintech-app
    tier: application
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: fintech-app
  minReplicas: 3
  maxReplicas: 20
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
  - type: Pods
    pods:
      metric:
        name: http_requests_per_second
      target:
        type: AverageValue
        averageValue: "1000"
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
      - type: Percent
        value: 10
        periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
      - type: Percent
        value: 100
        periodSeconds: 15
      - type: Pods
        value: 4
        periodSeconds: 15
      selectPolicy: Max
---
// === ARCHIVO: k8s/manifests/app/service.yaml ===
apiVersion: v1
kind: Service
metadata:
  name: fintech-app-service
  namespace: fintech-prod
  labels:
    app: fintech-app
    tier: application
    environment: production
spec:
  type: ClusterIP
  selector:
    app: fintech-app
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 8080
  - name: https
    protocol: TCP
    port: 443
    targetPort: 8443
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 10800
  publishNotReadyAddresses: false
  internalTrafficPolicy: Cluster

// === ARCHIVO: k8s/manifests/app/configmap.yaml ===
apiVersion: v1
kind: ConfigMap
metadata:
  name: fintech-app-config
  namespace: fintech-prod
  labels:
    app: fintech-app
    environment: production
data:
  # Configuración de la aplicación
  APP_ENV: "production"
  LOG_LEVEL: "info"
  API_TIMEOUT: "5000"
  
  # Configuración de base de datos
  DB_HOST: "postgres.finance.svc.cluster.local"
  DB_PORT: "5432"
  DB_NAME: "fintech_db"
  
  # Configuración de caché
  CACHE_ENABLED: "true"
  CACHE_TTL: "3600"
  
  # Configuración de rate limiting
  RATE_LIMIT_REQUESTS: "1000"
  RATE_LIMIT_WINDOW: "1s"
  
  # Configuración de métricas
  METRICS_ENABLED: "true"
  METRICS_PORT: "9090"
  
  # Configuración de health checks
  HEALTH_CHECK_INTERVAL: "30s"
  HEALTH_CHECK_TIMEOUT: "5s"

---

// === ARCHIVO: k8s/manifests/app/secret.yaml ===
apiVersion: v1
kind: Secret
metadata:
  name: fintech-app-secret
  namespace: fintech-prod
  labels:
    app: fintech-app
    environment: production
type: Opaque
data:
  # Credenciales de base de datos (base64)
  DB_USER: cG9zdGdyZXNfdXNlcg==
  DB_PASSWORD: Y2hhbmdlbWUxMjM=
  
  # Token de API externo
  EXTERNAL_API_TOKEN: c2VjcmV0X2FwaV90b2tlbl8xMjM0NTY=
  
  # Clave de firma de JWT
  JWT_SECRET_KEY: c3VwZXJfc2VjcmV0X2tleV9mb3Jfand0
  
  # Credenciales de Redis
  REDIS_PASSWORD: cmVkaXNfcGFzc3dvcmQ=
  
  # Certificados TLS (referenciados desde Secret existente)
  # tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0t...
  # tls.key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0t...

---

// === ARCHIVO: k8s/manifests/monitoring/prometheus.yaml ---# Configuración de Prometheus para monitoreo del cluster y aplicaciones
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  namespace: monitoring
  labels:
    app: prometheus
    component: configuration
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
      external_labels:
        cluster: 'fintech-production'
        environment: 'prod'
    
    alerting:
      alertmanagers:
        - static_configs:
            - targets:
              - alertmanager.monitoring.svc.cluster.local:9093
    
    rule_files:
      - '/etc/prometheus/rules/*.yml'
    
    scrape_configs:
      # Prometheus auto-descubrimiento
      - job_name: 'prometheus'
        static_configs:
          - targets: ['localhost:9090']
      
      # Métricas del API Server
      - job_name: 'kubernetes-apiserver'
        kubernetes_sd_configs:
          - role: endpoints
        scheme: https
        tls_config:
          ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
        relabel_configs:
          - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
            action: keep
            regex: default;kubernetes;https
      
      # Métricas de nodos
      - job_name: 'kubernetes-nodes'
        kubernetes_sd_configs:
          - role: node
        scheme: https
        tls_config:
          ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
        relabel_configs:
          - action: labelmap
            regex: __meta_kubernetes_node_label_(.+)
      
      # Métricas de pods
      - job_name: 'kubernetes-pods'
        kubernetes_sd_configs:
          - role: pod
        relabel_configs:
          - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
            action: keep
            regex: true
          - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
            action: replace
            target_label: __metrics_path__
            regex: (.+)
          - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
            action: replace
            regex: ([^:]+)(?::\d+)?;(\d+)
            replacement: $1:$2
            target_label: __address__
          - action: labelmap
            regex: __meta_kubernetes_pod_label_(.+)
          - source_labels: [__meta_kubernetes_namespace]
            action: replace
            target_label: kubernetes_namespace
          - source_labels: [__meta_kubernetes_pod_name]
            action: replace
            target_label: kubernetes_pod_name
      
      # Métricas de servicios
      - job_name: 'kubernetes-services'
        kubernetes_sd_configs:
          - role: service
        relabel_configs:
          - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
            action: keep
            regex: true
          - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
            action: replace
            target_label: __metrics_path__
            regex: (.+)
          - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
            action: replace
            regex: ([^:]+)(?::\d+)?;(\d+)
            replacement: $1:$2
            target_label: __address__
          - action: labelmap
            regex: __meta_kubernetes_service_label_(.+)
          - source_labels: [__meta_kubernetes_namespace]
            action: replace
            target_label: kubernetes_namespace

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-rules
  namespace: monitoring
  labels:
    app: prometheus
    component: rules
data:
  # Reglas de alerta para la aplicación fintech
  alerts.yml: |
    groups:
      - name: fintech-app-alerts
        interval: 30s
        rules:
          - alert: HighRequestRate
            expr: rate(http_requests_total[5m]) > 1000
            for: 2m
            labels:
              severity: critical
              component: api
            annotations:
              summary: "Alta tasa de solicitudes detectada"
              description: "La tasa de solicitudes HTTP supera las 1000 req/s"
          
          - alert: HighResponseTime
            expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 5
            for: 2m
            labels:
              severity: warning
              component: api
            annotations:
              summary: "Tiempo de respuesta alto"
              description: "El percentil 95 del tiempo de respuesta supera los 5 segundos"
          
          - alert: PodMemoryUsageHigh
            expr: (container_memory_usage_bytes / container_spec_memory_limit_bytes) > 0.85
            for: 5m
            labels:
              severity: warning
              component: resources
            annotations:
              summary: "Uso de memoria alto en pods"
              description: "El uso de memoria supera el 85% del límite"
          
          - alert: PodCPUUsageHigh
            expr: (rate(container_cpu_usage_seconds_total[5m]) / container_spec_cpu_quota) > 0.85
            for: 5m
            labels:
              severity: warning
              component: resources
            annotations:
              summary: "Uso de CPU alto en pods"
              description: "El uso de CPU supera el 85% del límite"
          
          - alert: PodRestartCount
            expr: increase(kube_pod_container_status_restarts_total[1h]) > 3
            for: 5m
            labels:
              severity: warning
              component: health
            annotations:
              summary: "Reinicios excesivos de pods"
              description: "Más de 3 reinicios en la última hora"
          
          - alert: ServiceEndpointDown
            expr: kube_endpoint_address_available{endpoint="http-api"} == 0
            for: 1m
            labels:
              severity: critical
              component: availability
            annotations:
              summary: "Endpoint de servicio no disponible"
              description: "El endpoint HTTP no tiene pods disponibles"


// === ARCHIVO: k8s/manifests/monitoring/grafana-dashboard.yaml ===
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboard-fintech
  namespace: monitoring
  labels:
    grafana_dashboard: "1"
    app: fintech-monitoring
data:
  fintech-dashboard.json: |-
    {
      "annotations": {
        "list": []
      },
      "editable": true,
      "fiscalYearStartMonth": 0,
      "graphTooltip": 0,
      "id": null,
      "links": [],
      "liveNow": false,
      "panels": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 80
                  }
                ]
              },
              "unit": "s"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 0
          },
          "id": 1,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket{job=\"fintech-app\"}[5m])) by (le))",
              "refId": "A"
            }
          ],
          "title": "Latencia P95 (segundos)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "palette-classic"
              },
              "custom": {
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 10,
                "gradientMode": "none",
                "hideFrom": {
                  "legend": false,
                  "tooltip": false,
                  "viz": false
                },
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                  "type": "linear"
                },
                "showPoints": "never",
                "spanNulls": false,
                "stacking": {
                  "group": "A",
                  "mode": "none"
                },
                "thresholdsStyle": {
                  "mode": "off"
                }
              },
              "mappings": [],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  }
                ]
              },
              "unit": "reqps"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 0
          },
          "id": 2,
          "options": {
            "legend": {
              "calcs": [],
              "displayMode": "list",
              "placement": "bottom",
              "showLegend": true
            },
            "tooltip": {
              "mode": "single",
              "sort": "none"
            }
          },
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "sum(rate(http_requests_total{job=\"fintech-app\"}[5m]))",
              "refId": "A"
            }
          ],
          "title": "Throughput (req/s)",
          "type": "timeseries"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [
                {
                  "options": {
                    "0": {
                      "color": "green",
                      "index": 0,
                      "text": "OK"
                    },
                    "1": {
                      "color": "red",
                      "index": 1,
                      "text": "ERROR"
                    }
                  },
                  "type": "value"
                }
              ],
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "green",
                    "value": null
                  },
                  {
                    "color": "red",
                    "value": 1
                  }
                ]
              },
              "unit": "percentunit"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 8
          },
          "id": 3,
          "options": {
            "colorMode": "background",
            "graphMode": "none",
            "justifyMode": "auto",
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "textMode": "auto"
          },
          "pluginVersion": "10.0.0",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "sum(rate(http_requests_total{job=\"fintech-app\",status=~\"5..\"}[5m])) / sum(rate(http_requests_total{job=\"fintech-app\"}[5m]))",
              "refId": "A"
            }
          ],
          "title": "Tasa de errores 5xx",
          "type": "stat"
        },
        {
          "datasource": {
            "type": "prometheus",
            "uid": "${DS_PROMETHEUS}"
          },
          "fieldConfig": {
            "defaults": {
              "color": {
                "mode": "thresholds"
              },
              "mappings": [],
              "max": 100,
              "min": 0,
              "thresholds": {
                "mode": "absolute",
                "steps": [
                  {
                    "color": "red",
                    "value": null
                  },
                  {
                    "color": "yellow",
                    "value": 70
                  },
                  {
                    "color": "green",
                    "value": 90
                  }
                ]
              },
              "unit": "percent"
            },
            "overrides": []
          },
          "gridPos": {
            "h": 8,
            "w": 12,
            "x": 12,
            "y": 8
          },
          "id": 4,
          "options": {
            "orientation": "auto",
            "reduceOptions": {
              "calcs": [
                "lastNotNull"
              ],
              "fields": "",
              "values": false
            },
            "showThresholdLabels": false,
            "showThresholdMarkers": true
          },
          "pluginVersion": "10.0.0",
          "targets": [
            {
              "datasource": {
                "type": "prometheus",
                "uid": "${DS_PROMETHEUS}"
              },
              "expr": "(1 - sum(rate(http_requests_total{job=\"fintech-app\",status=~\"2..\"}[5m])) / sum(rate(http_requests_total{job=\"fintech-app\"}[5m]))) * 100",
              "refId": "A"
            }
          ],
          "title": "Disponibilidad (%)",
          "type": "gauge"
        }
      ],
      "refresh": "5s",
      "schemaVersion": 38,
      "style": "dark",
      "tags": ["fintech", "production", "kubernetes"],
      "templating": {
        "list": [
          {
            "current": {
              "selected": false,
              "text": "Prometheus",
              "value": "Prometheus"
            },
            "hide": 0,
            "includeAll": false,
            "label": "Data Source",
            "multi": false,
            "name": "DS_PROMETHEUS",
            "options": [],
            "query": "prometheus",
            "refresh": 1,
            "regex": "",
            "skipUrlSync": false,
            "type": "datasource"
          }
        ]
      },
      "time": {
        "from": "now-1h",
        "to": "now"
      },
      "timepicker": {},
      "timezone": "",
      "title": "Fintech Innovations - Dashboard de Producción",
      "uid": "fintech-prod",
      "version": 1,
      "weekStart": ""
    }
---
# Stub: Este dashboard muestra métricas de latencia P95, throughput y tasa de errores.
# El estudiante debe personalizar los thresholds según los SLAs definidos (1000 req/s, timeout 5s).
// === ARCHIVO: k8s/manifests/networking/ingress.yaml ===
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: fintech-ingress
  namespace: fintech-prod
  annotations:
    # TLS automático con cert-manager
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    # Rate limiting: máximo 100 requests por segundo por IP
    nginx.ingress.kubernetes.io/limit-rps: "100"
    # Rate limiting: máximo 50 conexiones simultáneas por IP
    nginx.ingress.kubernetes.io/limit-connections: "50"
    # Timeouts
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "5"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "30"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "30"
    # Buffers
    nginx.ingress.kubernetes.io/proxy-body-size: "10m"
    # Seguridad
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/enable-rewrite-log: "true"
    # CORS
    nginx.ingress.kubernetes.io/enable-cors: "true"
    nginx.ingress.kubernetes.io/cors-allow-origin: "https://app.fintechinnovations.com"
    nginx.ingress.kubernetes.io/cors-allow-methods: "GET, POST, PUT, DELETE, OPTIONS"
    nginx.ingress.kubernetes.io/cors-allow-headers: "Authorization, Content-Type, X-Request-ID"
    # Rate limiting por endpoint crítico
    nginx.ingress.kubernetes.io/limit-rps: "100"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - api.fintechinnovations.com
        - www.fintechinnovations.com
      secretName: fintech-tls-secret
  rules:
    - host: api.fintechinnovations.com
      http:
        paths:
          - path: /api/v1/payments
            pathType: Prefix
            backend:
              service:
                name: fintech-payments-service
                port:
                  number: 8080
          - path: /api/v1/accounts
            pathType: Prefix
            backend:
              service:
                name: fintech-accounts-service
                port:
                  number: 8080
          - path: /api/v1/transactions
            pathType: Prefix
            backend:
              service:
                name: fintech-transactions-service
                port:
                  number: 8080
          - path: /api/v1/users
            pathType: Prefix
            backend:
              service:
                name: fintech-users-service
                port:
                  number: 8080
          - path: /
            pathType: Prefix
            backend:
              service:
                name: fintech-api-gateway
                port:
                  number: 8080
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: fintech-ingress-web
  namespace: fintech-prod
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/limit-rps: "200"
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "5"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "60"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "60"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - app.fintechinnovations.com
      secretName: fintech-web-tls-secret
  rules:
    - host: app.fintechinnovations.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: fintech-web-frontend
                port:
                  number: 80
---
# Stub: Ingress principal para API y frontend con TLS automático y rate limiting.
# El estudiante debe configurar los paths de servicios según la arquitectura de microservicios.
// === ARCHIVO: k8s/manifests/networking/network-policy.yaml ===
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-default-deny-all
  namespace: fintech-prod
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-api-gateway-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-api-gateway
  policyTypes:
    - Ingress
    - Egress
  ingress:
    # Permitir tráfico desde el Ingress Controller
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
      ports:
        - protocol: TCP
          port: 8080
    # Permitir tráfico desde servicios de monitoreo
    - from:
        - namespaceSelector:
            matchLabels:
              name: monitoring
      ports:
        - protocol: TCP
          port: 8080
  egress:
    # Permitir DNS
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
    # Permitir comunicación con servicios internos
    - to:
        - namespaceSelector:
            matchLabels:
              name: fintech-prod
      ports:
        - protocol: TCP
          port: 8080
    # Permitir acceso a APIs externas necesarias (AWS, servicios de pago)
    - to:
        - ipBlock:
            cidr: 0.0.0.0/0
            except:
              - 10.0.0.0/8
              - 172.16.0.0/12
              - 192.168.0.0/16
      ports:
        - protocol: TCP
          port: 443
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-payments-service-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-payments-service
  policyTypes:
    - Ingress
    - Egress
  ingress:
    # Solo el API Gateway puede acceder al servicio de pagos
    - from:
        - podSelector:
            matchLabels:
              app: fintech-api-gateway
      ports:
        - protocol: TCP
          port: 8080
  egress:
    # DNS
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53
    # Comunicación con base de datos
    - to:
        - podSelector:
            matchLabels:
              app: fintech-postgres
      ports:
        - protocol: TCP
          port: 5432
    # Comunicación con Redis para caché
    - to:
        - podSelector:
            matchLabels:
              app: fintech-redis
      ports:
        - protocol: TCP
          port: 6379
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-accounts-service-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-accounts-service
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: fintech-api-gateway
      ports:
        - protocol: TCP
          port: 8080
  egress:
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
    - to:
        - podSelector:
            matchLabels:
              app: fintech-postgres
      ports:
        - protocol: TCP
          port: 5432
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-transactions-service-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-transactions-service
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: fintech-api-gateway
      ports:
        - protocol: TCP
          port: 8080
  egress:
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
    - to:
        - podSelector:
            matchLabels:
              app: fintech-postgres
      ports:
        - protocol: TCP
          port: 5432
    - to:
        - podSelector:
            matchLabels:
              app: fintech-kafka
      ports:
        - protocol: TCP
          port: 9092
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-users-service-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-users-service
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: fintech-api-gateway
      ports:
        - protocol: TCP
          port: 8080
  egress:
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
    - to:
        - podSelector:
            matchLabels:
              app: fintech-postgres
      ports:
        - protocol: TCP
          port: 5432
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-database-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-postgres
  policyTypes:
    - Ingress
    - Egress
  ingress:
    # Solo servicios internos pueden acceder a la base de datos
    - from:
        - podSelector:
            matchLabels:
              app: fintech-payments-service
    - from:
        - podSelector:
            matchLabels:
              app: fintech-accounts-service
    - from:
        - podSelector:
            matchLabels:
              app: fintech-transactions-service
    - from:
        - podSelector:
            matchLabels:
              app: fintech-users-service
    - from:
        - podSelector:
            matchLabels:
              app: fintech-admin-service
      ports:
        - protocol: TCP
          port: 5432
  egress: []
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-redis-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-redis
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: fintech-payments-service
    - from:
        - podSelector:
            matchLabels:
              app: fintech-api-gateway
  egress: []
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fintech-monitoring-policy
  namespace: fintech-prod
spec:
  podSelector:
    matchLabels:
      app: fintech-exporter
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: monitoring
      ports:
        - protocol: TCP
          port: 8080
  egress:
    # Permitir métricas a Prometheus
    - to:
        - namespaceSelector:
            matchLabels:
              name: monitoring
      ports:
        - protocol: TCP
          port: 9090
---
# Stub: Políticas de red zero-trust para cumplimiento de seguridad en fintech.
# El estudiante debe ajustar las reglas según los requisitos específicos de cada servicio.


// === ARCHIVO: scripts/build.sh ===
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

// === ARCHIVO: scripts/healthcheck.sh ===
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


// === ARCHIVO: Dockerfile ===
# Stage 1: Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Stage 2: Production stage
FROM node:20-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./

USER node
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => process.exit(r.statusCode === 200 ? 0 : 1))"

CMD ["node", "dist/main.js"]

// === ARCHIVO: .dockerignore ===
# Version control
.git
.gitignore
.svn
.hg

# IDE and editor files
.idea
.vscode
*.swp
*.swo
*~
.DS_Store

# Build outputs and caches
dist
build
coverage
.nyc_output
.cache
.parcel-cache

# Dependencies
node_modules
npm-debug.log*
yarn-debug.log*
yarn-error.log*
package-lock.json
yarn.lock

# Environment files
.env
.env.local
.env.*.local
.env.development
.env.test
.env.production

# Logs
logs
*.log
npm-debug.log*

# Test files
__tests__
tests
*.test.js
*.spec.js
coverage
.nyc_output

# Documentation
README.md
docs/
*.md
LICENSE

# CI/CD
.github
.gitlab-ci.yml
Jenkinsfile
.azure-pipelines

# Terraform and infrastructure
terraform/
*.tf
*.tfstate*
*.tfvars
.k8s/

# Temporary files
tmp
temp
*.tmp
*.temp

# Docker files (avoid recursive build)
Dockerfile
docker-compose*.yml
.docker

// === ARCHIVO: README.md ===
# Fintech Innovations - Orquestación de Contenedores

## Descripción del Proyecto

Plataforma de orquestación de contenedores para aplicaciones fintech con alta disponibilidad y escalado automático.

## Estructura del Proyecto

```
/
├── .github/workflows/     # Pipelines de CI/CD
├── k8s/                   # Manifiestos de Kubernetes
│   ├── manifests/
│   │   ├── app/          # Deployments, services, configmaps
│   │   ├── networking/   # Ingress, network policies
│   │   └── monitoring/   # Prometheus, Grafana
├── scripts/              # Scripts de build y healthcheck
├── terraform/            # Infraestructura como código
│   ├── environments/     # Configuración por ambiente
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── providers.tf
├── Dockerfile            # Imagen multi-stage
├── .dockerignore
└── README.md
```

## Requisitos Previos

- Docker 24.0+
- Kubernetes 1.28+
- kubectl 1.28.0
- Helm 3.13.0
- Terraform 1.5+
- AWS CLI 2.0+

## Configuración de Entornos

### Variables de Entorno

Crear archivo `terraform/environments/{env}/terraform.tfvars` con los valores apropiados para cada ambiente.

### Construcción de Imagen Local

```bash
docker build -t fintech-app:local .
```

### Validación de Infraestructura

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

## Despliegue en Kubernetes

### Aplicar-manifiestos

```bash
kubectl apply -f k8s/manifests/
```

### Verificar Estado

```bash
kubectl get pods -n fintech
kubectl get services -n fintech
kubectl get ingress -n fintech
```

### Escalado Horizontal

El HPA está configurado para escalar automáticamente cuando se superen las 1000 solicitudes por segundo.

```bash
kubectl get hpa -n fintech
kubectl describe hpa app-hpa -n fintech
```

## Monitoreo

### Prometheus

```bash
kubectl port-forward -n monitoring svc/prometheus 9090:9090
```

### Grafana

```bash
kubectl port-forward -n monitoring svc/grafana 3000:3000
```

Credenciales por defecto: admin/admin (cambiar en producción).

## Seguridad

- Secrets gestionados via AWS Secrets Manager
- Network policies restringen tráfico entre pods
- TLS automático con cert-manager
- Escaneo de vulnerabilidades en CI/CD (Trivy, Checkov)

## Pipeline CI/CD

El pipeline incluye las siguientes etapas:
1. Build - Compilación de aplicación
2. Test - Ejecución de pruebas unitarias
3. Security Scan - Análisis estático y de dependencias
4. Build Image - Construcción de imagen Docker
5. Scan Image - Escaneo de vulnerabilidades de imagen
6. Deploy Staging - Despliegue en staging
7. Deploy Production - Despliegue en producción (con approval)

## Comandos de Mantenimiento

```bash
# Reiniciar deployment
kubectl rollout restart deployment/app -n fintech

# Ver logs
kubectl logs -f deployment/app -n fintech

# Escalado manual
kubectl scale deployment/app --replicas=5 -n fintech

# Rollback
kubectl rollout undo deployment/app -n fintech
```


// === ARCHIVO: .github/workflows/ci-cd.yml ===
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - prod

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}
  KUBERNETES_VERSION: '1.28.0'
  HELM_VERSION: '3.13.0'
  TERRAFORM_VERSION: '1.6.0'
  CHECKOV_VERSION: '3.1.0'
  TRIVY_VERSION: '0.48.0'

jobs:
  build:
    name: Build Application
    runs-on: ubuntu-latest
    outputs:
      image_tag: ${{ steps.meta.outputs.tags }}
      short_sha: ${{ steps.meta.outputs.short_sha }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata for Docker
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=sha,prefix=
            type=raw,value=latest,enable={{is_default_branch}}

      - name: Build Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

      - name: Run build script
        run: |
          chmod +x scripts/build.sh
          ./scripts/build.sh

      - name: Upload artifact
        uses: actions/upload-artifact@v4
        with:
          name: docker-image
          path: image.tar
          retention-days: 7

  static-analysis:
    name: Static Analysis (Checkov)
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run Checkov on Terraform
        uses: bridgecrewio/checkov-action@master
        with:
          directory: ./terraform
          framework: terraform
          output_format: sarif
          output_file_path: results/checkov-terraform.sarif

      - name: Run Checkov on Kubernetes manifests
        uses: bridgecrewio/checkov-action@master
        with:
          directory: ./k8s
          framework: kubernetes
          output_format: sarif
          output_file_path: results/checkov-k8s.sarif

      - name: Run Checkov on Dockerfile
        uses: bridgecrewio/checkov-action@master
        with:
          directory: .
          framework: dockerfile
          output_format: sarif
          output_file_path: results/checkov-dockerfile.sarif

      - name: Upload Checkov results
        uses: actions/upload-artifact@v4
        with:
          name: checkov-results
          path: results/

      - name: Publish checkov results to PR
        uses: dorny/paths-filter@v2
        if: github.event_name == 'pull_request'
        with:
          filters: |
            changes:
              - 'terraform/**'
              - 'k8s/**'
              - 'Dockerfile'
        if: filters.changes

  container-scan:
    name: Container Image Scan (Trivy)
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Download Docker image
        uses: actions/download-artifact@v4
        with:
          name: docker-image
          path: /tmp

      - name: Load Docker image
        run: |
          docker load -i /tmp/image.tar

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: '${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest'
          format: 'sarif'
          output: 'trivy-results.sarif'
          severity: 'CRITICAL,HIGH'
          vuln-type: 'os,lib'

      - name: Upload Trivy results
        uses: actions/upload-artifact@v4
        with:
          name: trivy-results
          path: trivy-results.sarif

      - name: Fail on critical vulnerabilities
        if: failure()
        run: |
          echo "Critical vulnerabilities found in container image"
          exit 1

  test-integration:
    name: Integration Tests
    runs-on: ubuntu-latest
    needs: [build, static-analysis, container-scan]
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up kubectl
        run: |
          curl -LO "https://dl.k8s.io/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl"
          chmod +x kubectl
          sudo mv kubectl /usr/local/bin/

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Run healthcheck
        run: |
          chmod +x scripts/healthcheck.sh
          ./scripts/healthcheck.sh staging

  deploy-staging:
    name: Deploy to Staging
    runs-on: ubuntu-latest
    needs: test-integration
    if: github.ref == 'refs/heads/develop' || github.event.inputs.environment == 'staging'
    environment:
      name: staging
      url: https://staging.fintechinnovations.example.com
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up kubectl
        run: |
          curl -LO "https://dl.k8s.io/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl"
          chmod +x kubectl
          sudo mv kubectl /usr/local/bin/

      - name: Set up Helm
        run: |
          curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
          chmod 700 get_helm.sh
          ./get_helm.sh --version v${HELM_VERSION}

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Update kubeconfig for staging
        run: |
          aws eks update-kubeconfig --name fintech-staging-cluster --region ${{ secrets.AWS_REGION }}

      - name: Deploy Kubernetes manifests
        run: |
          kubectl apply -f k8s/manifests/app/ -n staging
          kubectl apply -f k8s/manifests/networking/ -n staging

      - name: Deploy Prometheus
        run: |
          kubectl apply -f k8s/manifests/monitoring/prometheus.yaml -n monitoring

      - name: Deploy Grafana dashboards
        run: |
          kubectl apply -f k8s/manifests/monitoring/grafana-dashboard.yaml -n monitoring

      - name: Run healthcheck after deployment
        run: |
          sleep 30
          kubectl rollout status deployment/app -n staging --timeout=300s
          ./scripts/healthcheck.sh staging

      - name: Deploy HPA
        run: |
          kubectl apply -f k8s/manifests/app/hpa.yaml -n staging

  deploy-production:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: deploy-staging
    if: github.ref == 'refs/heads/main' || github.event.inputs.environment == 'prod'
    environment:
      name: production
      url: https://fintechinnovations.example.com
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up kubectl
        run: |
          curl -LO "https://dl.k8s.io/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl"
          chmod +x kubectl
          sudo mv kubectl /usr/local/bin/

      - name: Set up Helm
        run: |
          curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
          chmod 700 get_helm.sh
          ./get_helm.sh --version v${HELM_VERSION}

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ secrets.AWS_REGION }}

      - name: Update kubeconfig for production
        run: |
          aws eks update-kubeconfig --name fintech-prod-cluster --region ${{ secrets.AWS_REGION }}

      - name: Blue/Green deployment - Update production
        run: |
          kubectl apply -f k8s/manifests/app/ -n production
          kubectl apply -f k8s/manifests/networking/ -n production

      - name: Deploy monitoring stack
        run: |
          kubectl apply -f k8s/manifests/monitoring/prometheus.yaml -n monitoring
          kubectl apply -f k8s/manifests/monitoring/grafana-dashboard.yaml -n monitoring

      - name: Verify production deployment
        run: |
          sleep 60
          kubectl rollout status deployment/app -n production --timeout=300s
          ./scripts/healthcheck.sh prod

      - name: Configure HPA for production
        run: |
          kubectl apply -f k8s/manifests/app/hpa.yaml -n production

  notify-failure:
    name: Notify on Failure
    runs-on: ubuntu-latest
    needs: [deploy-staging, deploy-production]
    if: failure()
    steps:
      - name: Send failure notification
        run: |
          echo "Deployment failed - sending notification"
          curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
            -H 'Content-Type: application/json' \
            -d '{"text":"Deployment failed for ${{ github.repository }}"}'

```
