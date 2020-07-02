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
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}

#
# Sam Vars
#
variable "classic_storage_google_project" {
  # Today, we want to share a persistence layer between the deployment defined by this terraform and
  # broadinstitute/terraform-firecloud classic deployment. This variable is the corresponding classic deployment
  # google project.
  type        = string
  description = "The google project outside of the cluster that has storage."
}
variable "num_admin_sdk_service_accounts" {
  description = "How many Admin SDK service accounts to do GSuite group/user management to create."
  type        = number
}
