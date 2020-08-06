# See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
variable dependencies {
  type        = any
  default     = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}


#
# General Vars
#
variable "google_project" {
  type        = string
  description = "The google project in which to create resources"
}
variable "classic_storage_google_project" {
  # Today, we want to share a persistence layer between the deployment defined by this terraform and
  # broadinstitute/terraform-firecloud classic deployment. This variable is the corresponding classic deployment
  # google project.
  type        = string
  description = "The google project in which to look for a classic environment persistence layer. If empty defaults to google_project."
  default     = ""
}
locals {
  classic_storage_google_project = var.classic_storage_google_project == "" ? var.google_project : var.classic_storage_google_project
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
  owner = var.owner == "" ? terraform.workspace : var.owner
}
variable "preview" {
  type        = bool
  description = "Preview environment flag"
  default     = false
}


#
# Application toggles
#
variable "terra_apps" {
  type        = map(bool)
  description = "Terra apps to enable. All disabled by default."
  default     = {}
}
locals {
  terra_apps = merge({
    poc                   = false,
    identity_concentrator = false,
    sam                   = false,
    sam_persistence       = false,
    workspace_manager     = false,
    crl_janitor           = false,
    },
    var.terra_apps
  )
}

#
# DNS Vars
#
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
  default     = "dsp-envs"
}
variable "subdomain_name" {
  type        = string
  description = "Domain namespacing between zone and hostname"
  default     = ""
}
variable "use_subdomain" {
  type        = bool
  description = "Whether to use a subdomain between the zone and hostname"
  default     = true
}

#
# Workspace Manager Vars
#
variable "wsm_db_version" {
  type        = string
  default     = "POSTGRES_9_6"
  description = "The version for the WSM CloudSQL instance"
}
variable "wsm_db_keepers" {
  type        = bool
  default     = false
  description = "Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility"
}
