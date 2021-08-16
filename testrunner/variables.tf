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

variable "testrunner_sa_email" {
  type        = string
  description = "The email of the service account that will write files to the source bucket"
}

variable "files_source" {
  type        = string
  description = "The name of the google storage bucket (the string after gs://). To be used by Test Runner to temporarily store JSON files for consumption by streaming cloud function."
  default     = ""
}

variable "files_error" {
  type        = string
  description = "The name of the google storage bucket (the string after gs://). To be used by a cloud function to store error files."
  default     = ""
}

variable "files_success" {
  type        = string
  description = "The path of the google storage bucket (the string after gs://). To be used by a cloud function to store successfully ingested files."
  default     = ""
}

variable "files_region" {
  type        = string
  description = "Google region in which to create buckets"
  default     = "us-central1"
}

variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}

variable "cloud_functions_repo" {
  type        = string
  description = "The name of the Test Runner repo that is the source of cloud functions."
  default     = "terra-test-runner"
}

variable "bq_dataset_id" {
  type        = string
  description = "The name of the BigQuery dataset for ingestion."
  default     = "test_runner_results"
}

locals {
  service        = "testrunner"
  owner          = var.owner == "" ? terraform.workspace : var.owner
  files_source   = var.files_source == "" ? "${local.service}-results" : var.files_source
  files_error    = var.files_error == "" ? "${local.service}-streaming-errors" : var.files_error
  files_success  = var.files_success == "" ? "${local.service}-streaming-success" : var.files_success
}
