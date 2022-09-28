resource "kubernetes_namespace" "this" {
  metadata {
    annotations = {
      name = "${var.environment}-k8s-annotation"
    }

    labels = {
      app = "UrbanApp"
      env = var.environment
    }

    name = "${var.gcp_project}-${var.environment}"
  }
}
