variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "gcp_project" {
  type        = string
  description = "GCP Project name"
}

variable "environment" {
  type        = string
  description = "Infrastructure environment name"
}

variable "application_name" {
  type        = string
  description = "The Application Name"
  default     = "urban-app"
}

variable "application_label" {
  type        = string
  description = "The Application label"
  default     = "UrbanApp"
}

variable "application_version" {
  type        = string
  description = "The Application version"
  default     = "latest"
}

variable "tfstate_bucket_name" {
  type        = string
  description = "Terraform infrastructure state bucket"
}
