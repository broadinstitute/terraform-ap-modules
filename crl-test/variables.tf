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

# We separate whether the roles/billing.user is set on the CRL test SA as its own flag because the
# Broad SA that runs terraform does not want to have the broad permissions to set modify
# permissions on the service account. This was done manually instead for the Broad.
variable "enable_billing_user" {
  type        = boolean
  description = "Whether to set the CRL test SA as a billing user on the billing account."
  default     = true
}
