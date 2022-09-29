output "k8s_cluster_name" {
  value       = google_container_cluster.this.name
  description = "GKE Cluster Name"
}

output "k8s_cluster_host" {
  value       = google_container_cluster.this.endpoint
  description = "GKE Cluster Host"
}

output "project_container_registry_uri" {
  value       = google_container_registry.this.bucket_self_link
  description = "The URI of the created container registry"
}

# Display load balancer hostname
output "load_balancer_hostname" {
  value = kubernetes_ingress.this.status.0.load_balancer.0.ingress.0.hostname
}

# Display load balancer IP
output "load_balancer_ip" {
  value = kubernetes_ingress.this.status.0.load_balancer.0.ingress.0.ip
}
