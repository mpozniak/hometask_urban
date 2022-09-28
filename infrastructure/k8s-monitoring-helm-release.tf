resource "helm_release" "prometheus" {
  name       = "${var.environment}-monitoring-prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.id
}