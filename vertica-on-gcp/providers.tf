provider "google" {
  #credentials = file("vertica-on-gcp-4d4c41cd8a62.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "tls" {
  // no config needed
}

