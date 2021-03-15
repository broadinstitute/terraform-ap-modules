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
locals {
  cloudsql_pg12_defaults = {
    enable           = true,                        # Whether to create this CloudSQL instance
    version          = "POSTGRES_12",               # Version for CloudSQL instance
    keepers          = true,                        # Whether to use keepers to re-generate instance name
    tier             = "db-g1-small",               # The default tier (DB instance size) for the CloudSQL instance
    db_name          = local.service,               # Name of app DB
    db_user          = local.service,               # Name of app DB user
    stairway_db_name = "${local.service}-stairway", # Name of stairway DB
    stairway_db_user = "${local.service}-stairway", # Name of stairway DB user
  }
  cloudsql_pg13_defaults = {
    enable           = true,                        # Whether to create this CloudSQL instance
    version          = "POSTGRES_13",               # Version for CloudSQL instance
    keepers          = true,                        # Whether to use keepers to re-generate instance name
    tier             = "db-custom-4-8192",          # The default tier (DB instance size) for the CloudSQL instance
    db_name          = local.service,               # Name of app DB
    db_user          = local.service,               # Name of app DB user
    stairway_db_name = "${local.service}-stairway", # Name of stairway DB
    stairway_db_user = "${local.service}-stairway", # Name of stairway DB user
  }
}

variable "cloudsql_pg12_settings" {
  type        = map
  default     = {}
  description = "Settings for Postgres 12 CloudSQL instance"
}

variable "cloudsql_pg13_settings" {
  type        = map
  default     = {}
  description = "Settings for Postgres 13 CloudSQL instance"
}

locals {
  cloudsql_pg12_settings = merge(local.cloudsql_pg12_defaults, var.cloudsql_pg12_settings)
  cloudsql_pg13_settings = merge(local.cloudsql_pg13_defaults, var.cloudsql_pg13_settings)
}
