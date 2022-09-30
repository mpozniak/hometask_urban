terraform {
  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

data "google_client_config" "kubernetes" {}

data "template_file" "gke_cluster_endpoint" {
  template = data.terraform_remote_state.infrastructure.outputs.k8s_cluster_host
}

data "template_file" "access_token" {
  template = data.google_client_config.kubernetes.access_token
}

data "template_file" "gke_cluster_ca_certificate" {
  template = base64decode(data.terraform_remote_state.infrastructure.outputs.k8s_cluster_ca_certificate)
}

provider "kubernetes" {
  host                   = "https://${data.template_file.gke_cluster_endpoint.rendered}"
  token                  = data.template_file.access_token.rendered
  cluster_ca_certificate = data.template_file.gke_cluster_ca_certificate.rendered
}
