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