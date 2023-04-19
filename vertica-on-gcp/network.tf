module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.0"

  project_id   = var.project
  network_name = var.vpc_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "bastion-subnet"
      subnet_ip     = var.bastion_cidr
      subnet_region = var.region
      description   = "Bastion server region with public access"
    },
    {
      subnet_name   = "vertica-subnet"
      subnet_ip     = var.vertica_cidr
      subnet_region = var.region
      description   = "Vertica cluster subnet"
    }
  ]

}