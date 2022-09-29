terraform {
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.this.endpoint}"
  token                  = data.google_client_config.this.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.this.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.this.endpoint}"
    token                  = data.google_client_config.this.access_token
    client_certificate     = base64decode(google_container_cluster.this.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.this.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.this.master_auth.0.cluster_ca_certificate)
  }
}
