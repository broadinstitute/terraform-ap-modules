# See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
variable dependencies {
  type        = any
  default     = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}


#
# General Vars
#
variable "google_project" {
  type        = string
  description = "The google project"
}
variable "cluster" {
  description = "Terra GKE cluster suffix, whatever is after terra-"
}
variable "owner" {
  type        = string
  description = "Environment or developer"
  default     = ""
}
locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
  service = "workspace"
}


#
# Service Account Vars
#
locals {
  sa_roles = [
    "roles/storage.admin",
    "roles/container.admin"
  ]
}


#
# Postgres CloudSQL DB Vars
#
variable "db_tier" {
  default     = "db-g1-small"
  description = "The default tier (DB instance size) for the CloudSQL instance"
}
variable "db_name" {
  type        = string
  description = "Postgres db name"
  default     = ""
}
variable "db_user" {
  type        = string
  description = "Postgres username"
  default     = ""
}
variable "stairway_db_name" {
  type        = string
  description = "Stairway db name"
  default     = ""
}
variable "stairway_db_user" {
  type        = string
  description = "Stairway db username"
  default     = ""
}
locals {
  db_name = var.db_name == "" ? local.service : var.db_name
  db_user = var.db_user == "" ? local.service : var.db_user
  stairway_db_name = var.stairway_db_name == "" ? "${local.service}-stairway" : var.stairway_db_name
  stairway_db_user = var.stairway_db_user == "" ? "${local.service}-stairway" : var.stairway_db_user
}
