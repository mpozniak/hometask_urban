# Display load balancer hostname
output "load_balancer_hostname" {
  value = kubernetes_service_v1.this.status.0.load_balancer.0.ingress.0.hostname
}

# Display load balancer IP
output "load_balancer_ip" {
  value = kubernetes_service_v1.example.status.0.load_balancer.0.ingress.0.ip
}
