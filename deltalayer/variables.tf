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

variable "sourcewriter_sa_email" {
  type        = string
  description = "The email of the service account that will write files to the source bucket"
}

variable "bucket_suffix" {
  type        = string
  description = "Suffix to append to each bucket's name. Defaults to 'owner' variable if blank."
  default     = ""
}

variable "bucket_location" {
  type        = string
  description = "Google region in which to create buckets"
  default     = "us-central1"
}

#
# Streaming Cloud Function Vars
#
variable "source_archive_bucket" {
  description = "The GCS bucket containing the zip archive which contains the function"
  type        = string
}

variable "source_archive_object" {
  description = "The source archive object (file) in archive bucket"
  type        = string
}

variable "function_name" {
  type        = string
  description = "A user-defined name of the function. Function names must be unique globally"
}

variable "function_description" {
  type        = string
  description = "Description of the function"
}

variable "function_entry_point" {
  type        = string
  description = "Name of the function that will be executed when the Google Cloud Function is triggered"
}

variable "function_runtime_mb" {
  type        = string
  description = "Memory (in MB), available to the function. Default value is 256. Possible values include 128, 256, 512, 1024, etc"
  default     = 512
}

variable "bq_dataset" {
  type        = string
  description = "The user-defined BigQuery dataset for the streaming function"
}
variable "bq_tables" {
  type        = string
  description = "The BigQuery Table ID(s) that are exposed to the streaming function. Separate multiple tables by comma-delimited string"
}
variable "bq_table_schemas" {
  type        = map
  description = "A map of key-value pairs where the key represents the Table ID and value the corresponding Table Schema in JSON format"
}

##

variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}

locals {
  owner         = var.owner == "" ? terraform.workspace : var.owner
  bucket_suffix = var.bucket_suffix == "" ? local.owner : var.bucket_suffix
  service       = "deltalayer"
}

#
# Postgres CloudSQL DB Vars
#
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
variable "db_tier" {
  type        = string
  default     = "db-custom-4-8192" #relatively small; resize when/if needed
  description = "The default tier (DB instance size) for the CloudSQL instance"
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
locals {
  db_name = var.db_name == "" ? local.service : var.db_name
  db_user = var.db_user == "" ? local.service : var.db_user
}
