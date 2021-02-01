#
# General Vars
#
variable "google_project" {
  type        = string
  description = "The google project in which to create resources"
}
variable "cluster" {
  type        = string
  description = "Terra GKE cluster suffix, whatever is after terra-"
}
variable "replicas" {
  type        = number
  description = "Number of MongoDB replicas running in environment"
  default     = 3
}
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
