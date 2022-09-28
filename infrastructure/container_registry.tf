resource "google_container_registry" "this" {
  project  = var.gcp_project
  location = "US"
}
