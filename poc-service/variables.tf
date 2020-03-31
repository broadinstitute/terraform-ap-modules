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
  type = string
  description = "The google project"
}
variable "cluster" {
  description = "Terra GKE cluster suffix, whatever is after terra-"
}
variable "owner" {
  type = string
  description = "Environment or developer"
  default = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
variable "service" {
  description = "App name"
  default = "poc"
}


#
# Service Account Vars
#

variable "sa_roles" {
  type = list(string)
  description = "Service account roles"
  default = [
    "roles/storage.admin",
    "roles/container.admin"
  ]
}

#
# Postgres CloudSQL DB Vars
#
variable "db_tier" {
  default = "db-g1-small"
  description = "The default tier (DB instance size) for the CloudSQL instance"
}
variable "db_name" {
  type = string
  description = "Postgres db name"
  default = ""
}
variable "db_user" {
  type = string
  description = "Postgres username"
  default = ""
}
locals {
  db_name = var.db_name == "" ? var.service : var.db_name
  db_user = var.db_user == "" ? var.service : var.db_user
}
