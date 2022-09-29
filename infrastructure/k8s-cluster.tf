data "google_client_config" "this" {}

resource "google_container_cluster" "this" {
  name                     = "${var.environment}-k8s-cluster"
  location                 = var.gcp_region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.this.self_link
  subnetwork               = google_compute_subnetwork.private_subnet.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.gcp_project}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.environment}-${var.k8s_cluster_pod_ip_range["name"]}"
    services_secondary_range_name = "${var.environment}-${var.k8s_cluster_service_ip_range["name"]}"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.k8s_cluster_master_ip_range
  }
}
