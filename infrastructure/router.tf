resource "google_compute_router" "this" {
  name    = "${var.environment}-k8s-router"
  region  = google_compute_subnetwork.private_subnet.region
  network = google_compute_network.this.id
}
