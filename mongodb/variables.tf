#
# General Vars
#
variable "backup_bucket_location" {
  type        = string
  description = "Location of the backup bucket. Eg. 'us-central1'"
  default     = "us-central1"
}
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
