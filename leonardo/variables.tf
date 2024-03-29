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
variable "namespace" {
  type        = string
  description = "Optional Kubernetes namespace (defaults to terra-{cluster})"
  default     = ""
}
locals {
  namespace = var.namespace == "" ? "terra-${var.cluster}" : var.namespace
}

variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
  service = "leonardo-k8s" # K8s suffix is here for dns testing purposes, ot avoid overlap with GCE leonardo, will remove when ready to cut over
}

#
# DNS vars
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
# Service account config
#

variable "service_accounts" {
  type        = map(string)
  description = "Externally managed service accounts of Terra services."
  default     = { leonardo = "" }
}
variable "enable_workload_identity" {
  type        = bool
  description = "Enable configuring application service accounts for Workload Identity"
  default     = false
}
variable "kubernetes_sa_name" {
  type        = string
  description = "When Workload Identity is enabled, this Kubernetes SA in {namespace} will be able to impersonate Leonardo's Google SA"
  default     = "leonardo-sa"
}

#
# Used for the environment's Terra Docker Versions file bucket
#

variable "terra_docker_versions_upload_bucket" {
  type        = string
  description = "If not-null, create a publicly-readable, Leonardo-writable bucket for data serving"
  default     = null
}
