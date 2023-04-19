variable "project" {
  description = "Name of the google project in which Vertica will reside."
}

variable "region" {
  description = "GCP region"
}

variable "zone" {
  description = "GCP zone"
}

variable "vpc_name" {
  description = "VPC name for vertica"
  default     = "analytics_vpc"
}

variable "vm_type" {
  description = "Node type for vertica VMs"
  default     = "n1-standard-4"
}

variable "vm_prefix" {
  description = "VM name prefix for vertica instances"
}

variable "node_count" {
  description = "Number of nodes on cluster"
  type        = number

}

variable "bastion_cidr" {
  default = "10.70.5.0/24"
}

variable "vertica_cidr" {
  default = "10.70.2.0/24"
}