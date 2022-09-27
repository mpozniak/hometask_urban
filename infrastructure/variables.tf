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
