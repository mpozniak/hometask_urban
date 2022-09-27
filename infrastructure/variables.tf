# GCP region
variable "gcp_region" {
  type        = string
  description = "GCP region"
}

# GCP Project name
variable "gcp_project" {
  type        = string
  description = "GCP Project name"
}

# Environment name
variable "environment" {
  type        = string
  description = "Infrastructure environment name"
}

# GCP auth file
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
}

variable "k8s_cluster_subnet_ip_range" {
  type        = string
  description = "GC subnetwork IP CIDR range"
  default     = "172.20.0.0/16"
}

variable "k8s_cluster_master_ip_range" {
  type        = string
  description = "The IP range in CIDR notation to use for hosted master network"
  default     = "172.21.0.0/24"
}

variable "k8s_cluster_pod_ip_range" {
  type        = map(string)
  description = "k8s cluster POD IP range"
  default = {
    "name" = "k8s-pod-ip-range"
    "cidr" = "172.22.0.0/18"
  }
}

variable "k8s_cluster_service_ip_range" {
  type        = map(string)
  description = "k8s cluster Service IP range"
  default = {
    "name" = "k8s-service-ip-range"
    "cidr" = "172.22.64.0/18"
  }
}
