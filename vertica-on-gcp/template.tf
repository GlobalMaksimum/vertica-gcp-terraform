resource "local_file" "AnsibleInventory" {
  content = templatefile("${path.module}/inventory.j2",
    {
      vertica-dns             = google_compute_instance.vertica_nodes[*].name
      vertica-private         = google_compute_instance.vertica_nodes[*].network_interface[0].network_ip
      vertica_communal_bucket = google_storage_bucket.gcs_communal.name
#      vertica_backup_bucket   = module.eon_backup_bucket.s3_bucket_id
      access_id               = google_storage_hmac_key.key.access_id
      secret_key              = google_storage_hmac_key.key.secret
    }
  )
  filename = "ansible/inventory"
}