terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "proyectojenkins" {
  metadata {
    name = "proyectojenkins"
    labels = {
      app = "proyectojenkins"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "proyectojenkins"
      }
    }

    template {
      metadata {
        labels = {
          app = "proyectojenkins"
        }
      }

      spec {
        container {
          image = "jadapache/proyectojenkins:latest"
          name  = "proyectojenkins"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mi_api_service" {
  metadata {
    name = "mi-api-service"
  }
  spec {
    selector = {
      app = "mi-api"
    }
    port {
      port        = 80
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "mi_api_hpa" {
  metadata {
    name = "mi-api-hpa"
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "mi-api"
    }
    min_replicas = 2
    max_replicas = 10
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type  = "Utilization"
          average_utilization = 50
        }
      }
    }
  }
}
