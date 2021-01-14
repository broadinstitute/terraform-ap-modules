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
# Preview environment Vars
#
variable "versions" {
  type        = string
  description = "Base64 encoded JSON string of version overrides. Used for preview environments."
  default     = "eyJyZWxlYXNlcyI6e319Cg=="
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
    workspace_manager     = false,
    crl_janitor           = false,
    datarepo              = false,
    ontology              = false,
    buffer                = false,
    consent               = false,
    rawls                 = false,
    leonardo              = false,
    agora                 = false,
    firecloudorch         = false
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
# TODO (PF=156): Remove once WSM uses RBS.
variable "wsm_workspace_project_folder_id" {
  type        = string
  description = "What google folder within which to create a folder for creating workspace google projects. If empty, do not create a folder."
  default     = ""
}
variable "wsm_billing_account_ids" {
  type        = list(string)
  description = "List of Google billing account ids to allow WM to use for billing workspace google projects."
  default     = []
}
variable "wsm_db_version" {
  type        = string
  default     = "POSTGRES_12"
  description = "The version for the WSM CloudSQL instance"
}
variable "wsm_db_keepers" {
  type        = bool
  default     = false
  description = "Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility"
}
variable "wsm_buffer_pool_names" {
  type        = list(string)
  description = "Names of the buffer service pools that create projects for WSM."
  default     = []
}
# This field should be used in personal environments when the folder containing google projects
# comes from the tools RBS. Otherwise, all projects should be created by Buffer Service
# in the corresponding environment and the name of the pool should be passed in above.
variable "wsm_external_folder_ids" {
  type        = list(string)
  description = "Folders that WSM needs to access other than those managed by buffer service."
  default     = []
}

locals {
 wsm_folder_ids = concat(var.wsm_external_folder_ids, [for p in var.wsm_buffer_pool_names: module.buffer.pool_name_to_folder_id[p]])
}
#
# Prometheus / Grafana vars
#
variable "grafana_dns_name" {
  type        = string
  description = "DNS record name, excluding zone top-level domain. Eg. data.alpha"
  default     = ""
}

variable "prometheus_dns_name" {
  type        = string
  description = "DNS record name, excluding zone top-level domain. Eg. data.alpha"
  default     = ""
}

variable "grafana_static_ip_name" {
  type        = string
  default     = ""
  description = "Name of Data Repo's static IP"
}

variable "prometheus_static_ip_name" {
  type        = string
  default     = ""
  description = "Name of Data Repo's static IP"
}

#
# Datarepo Vars
#
variable "datarepo_dns_name" {
  type        = string
  description = "DNS record name, excluding zone top-level domain. Eg. data.alpha"
  default     = ""
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
variable "janitor_google_folder_ids" {
  type        = list(string)
  description = "List of folders Janitor has permission on."
  default     = []
}

# Terra Resource Buffer Vars
#
variable "buffer_billing_account_ids" {
  type        = list(string)
  description = "List of billing accounts Resource Buffer Service has permission to use."
  default     = []
}
variable "buffer_db_version" {
  type        = string
  default     = "POSTGRES_12"
  description = "The version for the Resource Buffer Service CloudSQL instance"
}
variable "buffer_db_keepers" {
  type        = bool
  default     = false
  description = "Whether to use keepers to re-generate instance name. Disabled by default for backwards-compatibility"
}
variable "buffer_root_folder_id" {
  type        = string
  description = "Parent folder under which to create all pool-specific folders. If empty, no folders will be created."
  default     = ""
}
variable "buffer_pool_names" {
  type        = list(string)
  description = "List of pools in this environment for which folders will be created and Buffer SA granted access to."
  default     = []
}
variable "buffer_external_folder_ids" {
  type        = list(string)
  description = "List of already existing folders that Buffer SA will get access to."
  default     = []
}

#
# Sam Vars
#
variable "sam_hostname" {
  description = "Sam ingress hostname"
  type        = string
  default     = "sam"
}
variable "sam_sdk_sa_count" {
  type        = number
  default     = 3
  description = "How many Sam admin SDK service accounts for GSuite group/user management to create."
}
variable "sam_firestore_project_name" {
  description = "Name for Sam Firestore project. Will default to sam-[workspace]-firestore if left blank."
  type        = string
  default     = ""
}
variable "sam_firestore_billing_account_id" {
  description = "Sam Firestore project billing account ID"
  type        = string
  default     = ""
}
variable "sam_firestore_folder_id" {
  description = "Sam Firestore project folder ID"
  type        = string
  default     = ""
}
