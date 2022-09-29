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

variable "application_version" {
  type        = string
  description = "Application version"
  default     = "latest"
}

variable "application_name" {
  type        = string
  description = "Application name"
}

variable "application_label" {
  type        = string
  description = "Application label"
}

variable "app_limits_cpu" {
  type        = string
  description = "CPU application limit"
  default     = "0.5"
}

variable "app_limits_memory" {
  type        = string
  description = "RAM application limit"
  default     = "64Mi"
}

variable "app_container_port" {
  type        = number
  description = "Application container port"
  default     = 3000
}

variable "app_host_port" {
  type        = number
  description = "Application host port"
  default     = 80
}

variable "app_liveness_probe_path" {
  type        = string
  description = "Application liveness probe path"
  default     = "/"
}
