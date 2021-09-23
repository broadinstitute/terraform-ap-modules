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

variable "testrunner_sa_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the TestRunner SA will be added."
  default     = [
    "roles/bigquery.user",
    "roles/container.viewer",
    "roles/storage.admin",
  ]
}

variable "testrunner_cf_deployer_sa_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the TestRunner Cloud Function Deployer SA will be added."
  default     = [
    "roles/cloudfunctions.admin",
  ]
}

variable "testrunner_cf_deployer_sa_runas_default_appspot_sa_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles which the TestRunner CF Deployer SA will be able to run as the Default AppSpot SA."
  default     = [
    "roles/iam.serviceAccountUser",
  ]
}

variable "testrunner_streamer_sa_iam_roles" {
  type        = list(string)
  description = "A list of one or more roles to which the TestRunner Streamer SA will be added."
  default     = [
    "roles/bigquery.user",
    "roles/iam.serviceAccountUser",
  ]
}

locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
  service = "testrunner"
}
