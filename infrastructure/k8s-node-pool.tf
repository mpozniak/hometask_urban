resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

resource "google_container_node_pool" "this" {
  name    = "${var.environment}-k8s-node-pool"
  cluster = google_container_cluster.this.id

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = var.k8s_cluster_min_node_count
    max_node_count = var.k8s_cluster_max_node_count
  }

  node_config {
    preemptible  = false
    machine_type = var.k8s_cluster_node_machine_type

    labels = {
      role        = "general"
      project     = var.gcp_project
      environment = var.environment
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
