data "google_client_config" "this" {}

resource "kubernetes_deployment" "application" {
  metadata {
    name      = "${var.environment}-k8s-app-deployment"
    namespace = "${var.gcp_project}-${var.environment}"
    labels = {
      app = "UrbanApp"
      env = var.environment
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "UrbanApp"
        env = var.environment
      }
    }

    template {
      metadata {
        labels = {
          app = "UrbanApp"
          env = var.environment
        }
      }

      spec {
        container {
          image = "${google_container_registry.this.bucket_self_link}/urban_app:latest"
          name  = "urban_app"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "256Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "64Mi"
            }
          }
          port {
            container_port = 3000
            host_port      = 80
            protocol       = "tcp"
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 3000

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
