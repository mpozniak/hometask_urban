resource "google_compute_subnetwork" "private_subnet" {
  name                     = "${var.environment}-private-subnet"
  ip_cidr_range            = "172.20.0.0/16"
  region                   = var.gcp_region
  network                  = google_compute_network.this.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.environment}-${var.k8s_cluster_pod_ip_range["name"]}"
    ip_cidr_range = var.k8s_cluster_pod_ip_range["cidr"]
  }
  secondary_ip_range {
    range_name    = "${var.environment}-${var.k8s_cluster_service_ip_range["name"]}"
    ip_cidr_range = var.k8s_cluster_service_ip_range["cidr"]
  }
}
