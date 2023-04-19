data "google_client_openid_userinfo" "me" {}


resource "google_compute_address" "static" {
  name = "bastion"
}

resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "n1-standard-1" # 4 vcore, 15 GB
  #zone         = local.gcp.zone

  tags = ["bastion-node"] // this receives the firewall rule

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }


  // Local SSD disk
  #   scratch_disk {
  #     interface = "SCSI"
  #   }

  network_interface {
    subnetwork = module.vpc.subnets_ids[0]

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  # metadata = {
  #   foo = "bar"
  # }

  # metadata_startup_script = "echo hi > /test.txt"
}

output "bastion-ip" {
  value = google_compute_address.static.address
}