resource "google_compute_subnetwork" "private_subnet" {
  name                     = "${var.environment}-private-subnet"
  ip_cidr_range            = "172.20.0.0/16"
  region                   = "us-central1"
  network                  = google_compute_network.this.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.environment}-k8s-pod-ip-range"
    ip_cidr_range = "172.21.0.0/18"
  }
  secondary_ip_range {
    range_name    = "${var.environment}-k8s-service-ip-range"
    ip_cidr_range = "172.21.64.0/18"
  }
}