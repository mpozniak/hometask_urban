resource "kubernetes_deployment" "application" {
  metadata {
    name      = "${var.environment}-${var.application_name}-deployment"
    namespace = "${var.environment}-${var.application_name}-namespace"
    labels = {
      app = var.application_label
      env = var.environment
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.application_label
        env = var.environment
      }
    }

    template {
      metadata {
        labels = {
          app = var.application_label
          env = var.environment
        }
      }

      spec {
        container {
          image = "gcr.io/${var.gcp_project}/${var.application_name}:${var.application_version}"
          name  = var.application_name

          resources {
            limits = {
              cpu    = var.app_limits_cpu
              memory = var.app_limits_memory
            }
            requests = {
              cpu    = "250m"
              memory = "64Mi"
            }
          }
          port {
            container_port = var.app_container_port
            host_port      = var.app_host_port
            protocol       = "TCP"
          }

          liveness_probe {
            http_get {
              path = var.app_liveness_probe_path
              port = var.app_container_port

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
