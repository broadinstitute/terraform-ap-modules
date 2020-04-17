variable "google_project" {
  description = "The google project"
}

variable "owner" {
  type        = string
  description = "Environment or developer"
  default     = ""
}
locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
}

variable "cloudsql_tier" {
  default = "db-f1-micro"
  description = "The default tier (DB instance size) for Application CloudSQL instances."
}