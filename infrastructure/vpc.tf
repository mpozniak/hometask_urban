resource "google_compute_network" "this" {
  name                            = "${var.environment}-cluster-vpc"
  project                         = var.gcp_project
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false
}
