resource "kubernetes_ingress" "this" {
  wait_for_load_balancer = true
  metadata {
    name      = "${var.environment}-k8s-ingress"
    namespace = "${var.gcp_project}-${var.environment}"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = kubernetes_service.this.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}
