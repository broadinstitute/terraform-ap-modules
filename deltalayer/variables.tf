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
}

variable "bucket_location" {
  type        = string
  description = "Google region in which to create buckets"
}

variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}

locals {
  owner           = var.owner == "" ? terraform.workspace : var.owner
  bucket_suffix   = var.bucket_suffix == "" ? var.owner : var.bucket_suffix
  bucket_location = var.bucket_location == "" ? "US-CENTRAL1" : var.bucket_location
  service         = "deltalayer"
}

