variable "google_project" {
  description = "The google project to create a diskmanager service account in"
}

variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}

locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
