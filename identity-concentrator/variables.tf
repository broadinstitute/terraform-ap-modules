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
  service = "ic"
}


#
# Service Account Vars
#
variable "sa_roles" {
  type        = list(string)
  description = "Service account roles"
  default = [
    "roles/cloudsql.client",                      // To use cloudsql
    "roles/cloudkms.cryptoKeyEncrypterDecrypter", // To encrypt sensitive data to store in datastore
    "roles/cloudkms.publicKeyViewer",             // To sign jwt with kms
    "roles/cloudkms.signer",                      // To sign jwt with kms
    "roles/datastore.indexAdmin",                 // TO mange datastore index
    "roles/datastore.user",                       // To use datastore
    "roles/cloudkms.admin",                       // To manage cryptographic keys for IC
    "roles/monitoring.editor"                     // To use stackdriver
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
