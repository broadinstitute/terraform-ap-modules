variable "google_project" {
  description = "The google project id to create for CRL to run integration tests within."
  type        = string
}

variable "folder_id" {
  type        = string
  description = "What folder to create google_project and a test folder under."
}

variable "billing_account_id" {
  type        = string
  description = "What billing account to assign to the project."
}
