data "terraform_remote_state" "infrastructure" {
  backend = "gcs"
  config = {
    bucket = var.tfstate_bucket_name
    prefix = "${var.gcp_project}-${var.environment}-infrastructure"
  }
}

module "urban_app" {
  source              = "../modules/application"
  application_name    = var.application_name
  application_label   = var.application_label
  application_version = var.application_version
  app_limits_cpu      = "0.5"
  app_limits_memory   = "128Mi"
  app_container_port  = 3000
  app_host_port       = 80
  gcp_region          = var.gcp_region
  gcp_project         = var.gcp_project
  environment         = var.environment
}
