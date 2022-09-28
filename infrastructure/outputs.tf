output "project_container_registry_uri" {
    value = google_container_registry.this.bucket_self_link
    description = "The URI of the created container registry"
}
