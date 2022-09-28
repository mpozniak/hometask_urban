resource "kubernetes_service" "this" {
  metadata {
    name      = "${var.environment}-k8s-app-ingress-service"
    namespace = "${var.gcp_project}-${var.environment}"
  }
  spec {
    selector = {
      app = kubernetes_deployment.application.metadata.0.labels.app
      env = var.environment
    }
    
    port {
      port        = 80
      target_port = 3000
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}
