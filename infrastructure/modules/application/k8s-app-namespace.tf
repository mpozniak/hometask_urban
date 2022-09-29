resource "kubernetes_namespace" "this" {
  metadata {
    annotations = {
      name = "${var.environment}-${var.application_name}-annotation"
    }

    labels = {
      app = var.application_label
      env = var.environment
    }

    name = "${var.environment}-${var.application_name}-namespace"
  }
}
