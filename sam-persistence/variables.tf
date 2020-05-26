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
  type = string
  description = "The google project"
}
variable "owner" {
  type        = string
  description = "Environment or developer"
  default     = ""
}
locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
}

#
# Postgres CloudSQL DB Vars
#
variable "cloudsql_tier" {
  type = string
  default = "db-f1-micro"
  description = "The default tier (DB instance size) for Application CloudSQL instances."
}
