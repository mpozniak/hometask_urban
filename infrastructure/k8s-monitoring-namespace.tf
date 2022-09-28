resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "${var.environment}-monitoring-namespace"
  }
}
