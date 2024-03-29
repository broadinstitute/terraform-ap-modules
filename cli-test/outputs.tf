#
# Service Account Outputs
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
#

output "service_account_email_admin" {
  value       = google_service_account.cli_test_admin.email
  description = "CLI Test Admin Google service account email"
}
