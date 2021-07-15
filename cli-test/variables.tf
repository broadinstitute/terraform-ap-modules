variable "google_project" {
  description = "The google project id to create for the CLI to create resources in."
  type        = string
}

variable "folder_id" {
  type        = string
  description = "What folder to create google_project in."
}

variable "billing_account_id" {
  type        = string
  description = "What billing account to assign google_project."
}

# We separate whether the roles/billing.user is set on the CLI test SA as its own flag because the
# Broad SA that runs terraform does not want to have the broad permissions to set modify
# permissions on the service account. This was done manually instead for the Broad.
variable "enable_billing_user" {
  type        = bool
  description = "Whether to set the CLI test SA as a billing user on the billing account."
  default     = true
}
