variable "google_project" {
  description = "The google project to create a diskmanager service account in"
}

locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
