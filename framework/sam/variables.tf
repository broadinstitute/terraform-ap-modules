variable "google_project" {
  description = "The google project"
}

variable "classic_storage_google_project" {
  # Today, we want to share a persistence layer between the deployment defined by this terraform and
  # broadinstitute/terraform-firecloud classic deployment. This variable is the corresponding classic deployment
  # google project.
  description = "The google project outside of the cluster that has storage."
}

variable "gcp_name_prefix" {
  description = "The string to prefix to GCP names to make them unique across different instantiations of this module."
}

variable "num_admin_sdk_service_accounts" {
  description = "How many Admin SDK service accounts to do GSuite group/user management to create."
  type        = number
}
