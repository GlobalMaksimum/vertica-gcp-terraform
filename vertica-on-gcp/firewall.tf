resource "google_compute_firewall" "allow_exteral_ssh" {
  name          = "allow-external-ssh"
  network       = module.vpc.network.network.name
  target_tags   = ["bastion-node"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "dns_resolution" {
  name          = "allow-external-dns-resolv"
  network       = module.vpc.network.network.name
  target_tags   = ["bastion-node"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "udp"
    ports    = ["53"]
  }
}

resource "google_compute_firewall" "bastion_ping" {
  name          = "allow-external-ping"
  network       = module.vpc.network.network.name
  target_tags   = ["bastion-node"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_acces_from_bastion" {
  name          = "allow-access-from-bastion"
  network       = module.vpc.network.network.name
  target_tags   = ["vertica-node"] // this targets our tagged VM
  source_ranges = [var.bastion_cidr]

  allow {
    protocol = "tcp"
    ports    = ["22","5433"]
  } 
}

resource "google_compute_firewall" "vertica_to_vertica_client_access" {
  name          = "allow-vertica-to-vertica-client-access"
  network       = module.vpc.network.network.name
  target_tags   = ["vertica-node"] // this targets our tagged VM
  source_ranges = [var.vertica_cidr]

  allow {
    protocol = "tcp"
    ports    = ["5433","22"]
  }
}

# resource "google_compute_firewall" "vertica_spread_tcp" {
#   name          = "allow-vertica-spread-tcp"
#   network       = module.vpc.network.network.name
#   target_tags   = ["vertica-node"] // this targets our tagged VM
#   source_ranges = [var.vertica_cidr]

#   allow {
#     protocol = "tcp"
#     ports    = ["4803","4804"]
#   }
# }

# {
#       from_port   = 4803
#       to_port     = 4804
#       protocol    = "tcp"
#       description = "Vertica Spread (TCP)"
#       cidr_blocks = local.vertica.subnet
#     },
#     {
#       from_port   = 4803
#       to_port     = 4804
#       protocol    = "udp"
#       description = "Vertica Spread (UDP)"
#       cidr_blocks = local.vertica.subnet
#     },
#     {
#       from_port   = 5434
#       to_port     = 5434
#       protocol    = "tcp"
#       description = "Internode communication"
#       cidr_blocks = local.vertica.subnet
#     },
#     {
#       from_port   = 5444
#       to_port     = 5444
#       protocol    = "tcp"
#       description = ""
#       cidr_blocks = local.vertica.subnet
#     },
#     {
#       from_port   = 50000
#       to_port     = 50000
#       protocol    = "tcp"
#       description = "Rsync"
#       cidr_blocks = local.vertica.subnet
#     }