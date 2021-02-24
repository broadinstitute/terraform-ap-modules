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
  type        = bool
  description = "Enable flag for this module. If set to false, no resources will be created."
  default     = true
}

variable "google_project" {
  type        = string
  description = "The google project in which to create resources"
}

variable "sourcewriter_sa_email" {
  type        = string
  description = "The email of the service account that will write files to the source bucket"
}

variable "bucket_suffix" {
  type        = string
  description = "Suffix to append to each bucket's name. Defaults to 'owner' variable if blank."
  default = ""
}

variable "bucket_location" {
  type        = string
  description = "Google region in which to create buckets"
  default = "us-central1"
}

variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}

locals {
  owner           = var.owner == "" ? terraform.workspace : var.owner
  bucket_suffix   = var.bucket_suffix == "" ? local.owner : var.bucket_suffix
  service         = "deltalayer"
}

#
# Postgres CloudSQL DB Vars
#
variable "db_version" {
  type        = string
  default     = "POSTGRES_12"
  description = "The version for the CloudSQL instance"
}
variable "db_keepers" {
  type        = bool
  default     = true
  description = "Whether to use keepers to re-generate instance name."
}
variable "db_tier" {
  type        = string
  default     = "db-n1-standard-2" #relatively small; resize when/if needed
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
  db_name     = var.db_name == "" ? local.service : var.db_name
  db_user     = var.db_user == "" ? local.service : var.db_user
}
