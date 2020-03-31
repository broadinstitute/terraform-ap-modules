# See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
variable dependencies {
  type = any
  default = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}


#
# General Vars
#

variable "google_project" {
  description = "The google project"
}
variable "owner" {
  description = "Environment or developer"
  default = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
variable "service" {
  description = "App name"
  default = "terra"
}


#
# k8s Vars
#

variable "cluster_location" {
  type = string
  default = "us-central1-a"
}
variable "cluster_name" {
  type = string
  default = ""
}
locals {
  cluster_name = var.cluster_name == "" ? "${var.service}-${local.owner}" : var.cluster_name
}
variable "cluster_network" {
  type = string
  default = ""
}
locals {
  cluster_network = var.cluster_network == "" ? "${var.service}-${local.owner}" : var.cluster_network
}
variable "k8s_version_prefix" {
 default = "1.15.9"
}
variable "private_master_ipv4_cidr_block" {
  default = "10.128.18.0/28"
}
variable "node_pools" {
  default = [
    {
      name = "default",
      node_count = 6,
      machine_type = "n1-standard-4",
      disk_size_gb = 200,
      labels = {
        test_label_foo = "test_label_bar"
      }
    }
  ]
}



#
# CI SA vars
#

variable "ci_sa_roles" {
  type = list(string)
  default = [
    "roles/storage.admin",
    "roles/container.admin"
  ]
}
