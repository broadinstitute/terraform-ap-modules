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
  service = "workspace"
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
# Service Vars
#
// TODO(PF-156) Remove this once WM switches to using RBS
variable "workspace_project_folder_id" {
  type        = string
  description = "What google folder within which to create a folder for creating workspace google projects. If empty, do not create a folder."
  # Use empty string as a default value as TF has problems with null as a default between modules.
  # https://github.com/hashicorp/terraform/issues/21702
  default = ""
}
// workspace_project_folder_ids will replace the workspace_project_folder_id above. Key difference is that these folders are not created by WSM.
variable "workspace_project_folder_ids" {
  type        = list(string)
  description = "List of folder ids WSM will need to be able to access. Folders are created outside of WSM."
  default     = []
}
# This is mostly helpful for testing deployments. Eventually, we want users to bring their billing accounts to WM dynamically.
variable "billing_account_ids" {
  type        = list(string)
  description = "List of Google billing account ids to allow WSM to use for billing workspace google projects."
  default     = []
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
  db_name          = var.db_name == "" ? local.service : var.db_name
  db_user          = var.db_user == "" ? local.service : var.db_user
  stairway_db_name = var.stairway_db_name == "" ? "${local.service}-stairway" : var.stairway_db_name
  stairway_db_user = var.stairway_db_user == "" ? "${local.service}-stairway" : var.stairway_db_user
}
