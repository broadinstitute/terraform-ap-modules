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

variable "enable_dashboard" {
  type        = bool
  description = "Enable flag for TestRunner dashboard. If set to false, no resources related to TestRunner dashboard will be created."
  default     = false
}

variable "dashboard_namespace" {
  type        = string
  description = "The Kubernetes namespace of the TestRunner Dashboard"
  default     = "default"
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

variable "bucket_location" {
  type        = string
  description = "Google region in which to create buckets"
  default     = "us-central1"
}

variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}

variable "testrunner_sa_project_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the TestRunner SA will be added."
  default = [
    "roles/bigquery.user",
    "roles/container.viewer",
    "roles/storage.admin",
  ]
}

variable "testrunner_cf_deployer_sa_project_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the TestRunner Cloud Function Deployer SA will be added."
  default = [
    "roles/cloudfunctions.admin",
  ]
}

variable "testrunner_streamer_sa_project_iam_roles" {
  type        = list(string)
  description = "A list of one or more project roles to which the TestRunner Streamer SA will be added."
  default = [
    "roles/bigquery.user",
  ]
}

variable "testrunner_streamer_sa_storage_bucket_iam_roles" {
  type        = list(string)
  description = "A list of one or more storage bucket roles to which the TestRunner Streamer SA will be added."
  default = [
    "roles/storage.admin",
  ]
}

variable "gsp_automatic_sa_testrunner_results_bucket_pubsub_topic_publish_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles which the GSP Automatic SA will use to publish results to the TestRunner Results Bucket Topic."
  default = [
    "roles/pubsub.publisher",
  ]
}

locals {
  owner            = var.owner == "" ? terraform.workspace : var.owner
  service          = "testrunner"
  dashboardservice = "trdash"
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
# TestRunner Dashboard DNS Vars
#
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
  default     = "dsp-envs"
}

variable "subdomain_name_enable" {
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
  hostname       = var.hostname == "" ? local.dashboardservice : var.hostname
  cluster_name   = var.cluster_short == "" ? var.cluster : var.cluster_short
  subdomain_name = var.subdomain_name_enable ? (var.subdomain_name == "" ? ".${local.owner}.${local.cluster_name}" : var.subdomain_name) : ""
}

## The following entities were added on 24 Sep 2021 as part of a temporary
## workaround to address the IAM storage.admin role SA membership issue that
## manifested as part of QA-1485 and QA-1526. See JIRA issue DDO-1542 for details.
#
# These variables will need to remain in this file until the following items are
# complete:
# - The changes for QA-1526 have been merged to master in terraform-ap-modules and
#   terraform-ap-deployments.
# - The changes required to manage these non-TestRunner entities have been moved
#   to a common IAM module.

variable "firecloud_sa_project_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the Firecloud SA will be added."
  default = [
    "roles/storage.admin",
  ]
}

variable "firecloud_sa_name" {
  type    = string
  default = ""
}

variable "leonardo_sa_project_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the Leonardo SA will be added."
  default = [
    "roles/storage.admin",
  ]
}

variable "leonardo_sa_name" {
  type    = string
  default = ""
}

variable "sam_sa_project_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the Sam SA will be added."
  default = [
    "roles/storage.admin",
  ]
}

variable "sam_sa_name" {
  type    = string
  default = ""
}
