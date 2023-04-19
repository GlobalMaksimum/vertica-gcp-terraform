# Create a new service account
resource "google_service_account" "dbadmin_account" {
  account_id = "vertica-dbadmin"
}

#Create the HMAC key for the associated service account 
resource "google_storage_hmac_key" "key" {
  service_account_email = google_service_account.dbadmin_account.email
}

output "key" {
  value = {
    Access = google_storage_hmac_key.key.access_id
    Secret = google_storage_hmac_key.key.secret
  }
}