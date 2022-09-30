resource "kubernetes_ingress_v1" "this" {
  wait_for_load_balancer = false
  metadata {
    name      = "${var.environment}-${var.application_name}-ingress"
    namespace = "${var.environment}-${var.application_name}-namespace"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          path = "/*"
          backend {
            service {
              name = kubernetes_service_v1.this.metadata.0.name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
