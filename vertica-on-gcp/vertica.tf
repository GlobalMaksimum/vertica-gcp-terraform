resource "google_compute_instance" "vertica_nodes" {
  count        = var.node_count
  name         = "${var.vm_prefix}${count.index}"
  machine_type = var.vm_type
  #zone         = local.gcp.zone

  tags = ["vertica-node"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }
  allow_stopping_for_update = true

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    subnetwork = module.vpc.subnets_ids[1]

    access_config {
      // Ephemeral public IP
    }
  }

  # metadata = {
  #   foo = "bar"
  # }

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.dbadmin_account.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_disk" "catalog" {
  count = var.node_count
  name  = "${var.vm_prefix}-catalog${count.index}"
  type  = "pd-extreme"
  size  = 50
}

# output "catalog" {
#   value = google_compute_disk.catalog
# }

resource "google_compute_attached_disk" "default" {
  count    = var.node_count
  disk     = google_compute_disk.catalog[count.index].self_link
  instance = google_compute_instance.vertica_nodes[count.index].self_link
}

output "vertica_nodes" {
  value = {
    Name = google_compute_instance.vertica_nodes[*].name
    IP   = google_compute_instance.vertica_nodes[*].network_interface[0].network_ip
  }
}