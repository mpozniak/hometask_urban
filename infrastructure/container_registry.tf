resource "google_container_registry" "this" {
  project  = var.gcp_project
  location = "US"
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_container_registry.this.id
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.kubernetes.email}"
}