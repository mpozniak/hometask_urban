resource "kubernetes_ingress_v1" "this" {
  wait_for_load_balancer = true
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
              name = kubernetes_service.this.metadata.0.name
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
