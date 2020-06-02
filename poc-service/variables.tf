#
# General Vars
#
variable "dependencies" {
  # See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
  type        = any
  default     = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}
variable "enable" {
  type = bool
  description = "Enable flag for this module. If set to false, no resources will be created."
  default = true
}
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
  service = "poc"
}

#
# Service Account Vars
#
locals {
  sa_roles = [
    "roles/cloudsql.client"
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
locals {
  db_name = var.db_name == "" ? local.service : var.db_name
  db_user = var.db_user == "" ? local.service : var.db_user
}

#
# DNS Vars
#
variable "dns_zone_name" {
  type = string
  description = "DNS zone name"
  default = "dsp-envs"
}
variable "domain_name" {
  type = string
  description = "Domain name before zone"
  default = ""
}
locals {
  domain_name = var.domain_name == "" ? "${local.service}.${local.owner}.${var.cluster}"
}
