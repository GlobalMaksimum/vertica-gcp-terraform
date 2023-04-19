resource "google_storage_bucket" "gcs_communal" {
  name     = "gm-vertica-prod-xyz"
  location = var.region
  #force_destroy = true

  uniform_bucket_level_access = true
}

# output "dbadmin" {
#   value = google_service_account.dbadmin_account
# }

resource "google_storage_bucket_iam_member" "dbadmin_access" {
  bucket = google_storage_bucket.gcs_communal.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.dbadmin_account.email}"
}

output "bucket" {
  value = {
    Name = google_storage_bucket.gcs_communal.name
  }
}