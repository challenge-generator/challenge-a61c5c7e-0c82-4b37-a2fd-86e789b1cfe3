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