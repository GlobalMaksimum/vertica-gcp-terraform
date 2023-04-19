module "gcp_vertica_cluster" {
  source = "./vertica-on-gcp"

  project = "vertica-gcp-13425"
  region  = "europe-west3"
  zone    = "europe-west3-c"

  vpc_name = "gm-analytics-vpc"

  vm_prefix = "vsunny-clone"

  node_count = 4
}

output "general" {
  value = module.gcp_vertica_cluster
  sensitive = true
}














# output "bastion-ip" {
#   value = google_compute_address.static
# }

# output "me" {
#   value = data.google_client_openid_userinfo.me
# }