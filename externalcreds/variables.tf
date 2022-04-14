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
variable "ssh_keypair_encryption_kms_keyring" {
  type        = string
  description = "name of the kms key ring for encrypting/decrypting ssh keys in the ECM database."
  default     = ""
}

variable "ssh_keypair_encryption_kms_key" {
  type        = string
  description = "name of the kms key id for encrypting/decrypting ssh keys in the ECM database."
  default     = ""
}

locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
  service = "externalcreds"
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
# Postgres CloudSQL DB Vars
#
locals {
  cloudsql_pg13_defaults = {
    enable           = true,                        # Whether to create this CloudSQL instance
    version          = "POSTGRES_13",               # Version for CloudSQL instance
    keepers          = true,                        # Whether to use keepers to re-generate instance name
    tier             = "db-custom-4-8192",          # The default tier (DB instance size) for the CloudSQL instance
    db_name          = local.service,               # Name of app DB
    db_user          = local.service,               # Name of app DB user
  }
}

variable "cloudsql_pg13_settings" {
  type        = map
  default     = {}
  description = "Settings for Postgres 13 CloudSQL instance"
}

locals {
  cloudsql_pg13_settings = merge(local.cloudsql_pg13_defaults, var.cloudsql_pg13_settings)
}
