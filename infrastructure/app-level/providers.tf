terraform {
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.infrastructure.outputs.k8s_cluster_host}"
  token                  = data.terraform_remote_state.infrastructure.outputs.k8s_cluster_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.infrastructure.outputs.k8s_cluster_ca_certificate)
}
