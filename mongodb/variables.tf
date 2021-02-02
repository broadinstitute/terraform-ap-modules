#
# General Vars
#
variable "google_project" {
  type        = string
  description = "The google project in which to create resources"
}
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
