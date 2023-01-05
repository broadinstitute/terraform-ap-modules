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
variable "cluster" {
  type        = string
  description = "Terra GKE cluster suffix, whatever is after terra-"
}
variable "cluster_short" {
  type        = string
  description = "Optional short cluster name"
  default     = ""
}
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
  service = "sam"
}

#
# Environment types:
#   default: Standard persistent environments that contain a 'prod-like' set of infrastructure
#   preview: Short-lived, ephemeral environments with various shortcuts and resource sharing to make them lightweight & quick to spin up/down
#   preview_shared: A deployment with all of the infrastructure that is shared between the preview environments
variable "env_type" {
  type        = string
  description = "Environment type. Valid values are 'preview', 'preview_shared', and 'default'"
  default     = "default"
}

#
# DNS Vars
#
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
  default     = "dsp-envs"
}
variable "use_subdomain" {
  type        = bool
  description = "Whether to use a subdomain between the zone and hostname"
  default     = true
}
variable "subdomain_name" {
  type        = string
  description = "Domain namespacing between zone and hostname"
  default     = ""
}
variable "hostname" {
  type        = string
  description = "Service hostname"
  default     = ""
}
locals {
  hostname       = var.hostname == "" ? local.service : var.hostname
  cluster_name   = var.cluster_short == "" ? var.cluster : var.cluster_short
  subdomain_name = var.use_subdomain ? (var.subdomain_name == "" ? ".${local.owner}.${local.cluster_name}" : var.subdomain_name) : ""
}

#
# Sam Vars
#
variable "num_admin_sdk_service_accounts" {
  description = "How many Admin SDK service accounts to do GSuite group/user management to create."
  type        = number
  default     = 3
}
