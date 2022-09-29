resource "kubernetes_service" "this" {
  metadata {
    name      = "${var.environment}-${var.application_name}-ingress-service"
    namespace = "${var.environment}-${var.application_name}-namespace"
  }
  spec {
    selector = {
      app = kubernetes_deployment.application.metadata.0.labels.app
      env = var.environment
    }

    port {
      port        = var.app_host_port
      target_port = var.app_container_port
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}
