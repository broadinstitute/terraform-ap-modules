#
# Service Account Outputs
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
#

output "service_account_email" {
  value       = google_service_account.janitor_test.email
  description = "Google service account email in Janitor test"
}

