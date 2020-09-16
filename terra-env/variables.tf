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


#
# Preview environment Vars
#
variable "preview" {
  type        = bool
  description = "Preview environment flag. Set to true if creating a preview environment."
  default     = false
}
variable "preview_shared" {
  type        = bool
  description = "Preview environment shared resource flag. Set to true if creating a deployment for resources shared by all preview environments."
  default     = false
}
variable "preview_versions" {
  type = string
  description = "Base64 encoded JSON string of version overrides. Used for preview environments."
  default = "Cg=="
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
    datarepo              = false,
    ontology              = false,
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

#
# Datarepo Vars
#
variable "datarepo_dns_name" {
  type        = string
  default     = ""
  description = "Name for the Data Repo DNS record. Eg. data.alpha"
}
variable "datarepo_dns_zone_name" {
  type        = string
  default     = ""
  description = "Zone where Data Repo DNS record should be provisioned"
}
variable "datarepo_dns_zone_project" {
  type        = string
  default     = ""
  description = "Google Project where Data Repo DNS zone lives"
}
variable "datarepo_static_ip_name" {
  type        = string
  default     = ""
  description = "Name of Data Repo's static IP"
}
variable "datarepo_static_ip_project" {
  type        = string
  default     = ""
  description = "Project where of Data Repo's static IP lives"
}

# CRL Janitor Vars
#
variable "janitor_google_folder_id" {
  type        = string
  default     = ""
  description = "The folder ID in which Janitor has permission to cleanup resources."
}
