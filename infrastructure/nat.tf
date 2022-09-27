resource "google_compute_router_nat" "this" {
  name   = "${var.environment}-k8s-nat"
  router = google_compute_router.this.name
  region = google_compute_router.this.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat_external_static.self_link]
}

resource "google_compute_address" "nat_external_static" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [google_project_service.compute_api]
}
