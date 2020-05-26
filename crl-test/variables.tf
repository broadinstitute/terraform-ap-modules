variable "google_project" {
  description = "The google project id to create for cRL to run integration tests within."
  type = string
}

variable "folder_id" {
  type = string
  description = "What folder to create google_project under."
  default = null
}

variable "billing_account_id" {
  type = string
  description = "What billing account to assign to the project."
  default = null
}

variable "owner" {
  type = string
  description = "Environment or developer"
  default = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}