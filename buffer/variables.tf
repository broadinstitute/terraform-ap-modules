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
<<<<<<< HEAD
variable "google_folder_ids" {
  type        = list(string)
  description = "List of folders Resource Buffer Service has permission on."
  default     = []
}
=======
>>>>>>> 5d1e1c6 ([PF-323] Update variable names and descriptions in Buffer Terraform. (#126))
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
  service = "buffer"
}

#
# IP Vars
#
variable "global_ip" {
  type        = bool
  description = "Whether to make the IP global"
  default     = false
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
variable "db_tier" {
  default     = "db-g1-small"
  description = "The default tier (DB instance size) for the CloudSQL instance"
}
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

#
# List of billing accounts Resource Buffer Service has permissions on.
#
# We separate whether the roles/billing.user is set on the Resource Buffer Service SA as its own flag because the
# Broad SA that runs terraform does not want to have the broad permissions to set modify
# permissions on the service account. This was done manually instead for the Broad.
variable "billing_account_ids" {
  type        = list(string)
  description = "List of Google billing account ids to allow Resource Buffer Service to use"
  default     = []
}

# Root folder for this environment. A single folder will be created under the root folder for all
# buffer service resources, and then pool specific folders under that, i.e. structure will be
# {root_folder_id}/buffer-{env}/{pool_name} for each pool_name passed in below. The id of the
# bottom level folder must be the value of parentFolderId in the buffer service configuration.
variable "root_folder_id" {
  type        = string
  description = "Folder under which all projects will be created for this environment. If empty, no folders will be created."
  default     = ""
}

# For each pool in this list, a folder will be created and buffer service Service Account will
# be granted permission. See root_folder_id docs for folder structure. Pool name is the pool id
# from the buffer service configuration without version information.
variable "pool_names" {
  type        = list(string)
  description = "List of pools for which folders will be created and Buffer Service Account granted access to."
  default     = []
}

# This field should only be used if there is a good reason to prefer a manually managed folder for a particular pool.
variable "external_folder_ids" {
  type        = list(string)
  description = "List of already existing folders that Buffer Service Account will be granted access to."
  default     = []
}
