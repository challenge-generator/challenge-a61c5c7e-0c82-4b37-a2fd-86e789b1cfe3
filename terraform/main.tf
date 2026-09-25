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