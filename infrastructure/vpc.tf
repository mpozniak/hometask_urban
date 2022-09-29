# Allows management of a single API service for a Google Cloud Platform project
# resource "google_project_service" "compute_api" {
#   service                    = "compute.googleapis.com"
#   project                    = var.gcp_project
#   disable_dependent_services = true
# }

# resource "google_project_service" "container_api" {
#   service                    = "container.googleapis.com"
#   project                    = var.gcp_project
#   disable_dependent_services = true
# }

resource "google_compute_network" "this" {
  name                            = "${var.environment}-cluster-vpc"
  project                         = var.gcp_project
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

  # depends_on = [
  #   google_project_service.compute_api,
  #   # google_project_service.container_api
  # ]
}
