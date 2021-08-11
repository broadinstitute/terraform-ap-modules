variable "google_project" {
  type        = string
  description = "The google project in which to create resources"
}
variable "sourcewriter_sa_email" {
  type        = string
  description = "The email of the service account that will write files to the source bucket"
}
variable "billing_account_id" {
  description = "Billing account id"
}
variable "k8s_namespace" {
  type        = string
  description = "Terra GKE namespace suffix, whatever is after terra-"
}
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
  service = "testrunner"
}
