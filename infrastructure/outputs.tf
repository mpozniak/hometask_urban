output "gcp_region" {
  value       = var.gcp_region
  description = "GCP Infrastructure region"
}

output "k8s_cluster_name" {
  value       = google_container_cluster.this.name
  description = "GKE Cluster Name"
}

output "k8s_cluster_host" {
  value       = google_container_cluster.this.endpoint
  description = "GKE Cluster Host"
}

output "k8s_cluster_token" {
  value       = data.google_client_config.this.access_token
  description = "GKE Cluster Host token"
  sensitive   = true
}

output "k8s_cluster_ca_certificate" {
  value       = google_container_cluster.this.master_auth.0.cluster_ca_certificate
  description = "GKE Cluster CA Certificate"
  sensitive   = true
}

output "project_container_registry_uri" {
  value       = google_container_registry.this.bucket_self_link
  description = "The URI of the created container registry"
}

output "gcp_project" {
  value       = var.gcp_project
  description = "GCP Project name"
}

output "gcp_project_environment" {
  value       = var.environment
  description = "GCP Project environment"
}

output "gcp_service_account_email" {
  value       = google_service_account.kubernetes.email
  description = "GCP Project service account email"
}
