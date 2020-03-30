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
  default = "framework"
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
  cluster_network = var.cluster_network == "" ? var.service : var.cluster_network
}
variable "k8s_version_prefix" {
 default = "1.15.9-gke.24"
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
# PostgreSQL CloudSQL Vars
#

variable "postgres_app_dbs" {
  description = "List of PostgreSQL db name and username pairs"
  type = map(object({
    db = string
    username = string
  }))
  default = {
    kernel-service-poc = {
      db = "poc"
      username = "poc"
    }
  }
}
variable "cloudsql_tier" {
  default = "db-custom-16-32768"
  description = "The default tier (DB instance size) for the CloudSQL instance"
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


#
# Application SA vars
#

variable "app_service_accounts" {
  description = "List of application service accounts and their roles required per environment"
  type = map(object({
    roles = list(string)
  }))
  default = {
    kernel-service-poc = {
      roles = [
        "roles/cloudsql.client"
      ]
    }
  }
}


#
# Environment vars
#
variable "envs" {
  type = list(string)
  default = []
  description = "A list of environments for each of which some resources need to be duplicated"
}
