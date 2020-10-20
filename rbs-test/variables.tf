variable "google_project" {
  description = "The google project id to RBS test resources within"
  type        = string
}

variable "billing_account_id" {
  type        = string
  description = "What billing account to assign to the project."
}
