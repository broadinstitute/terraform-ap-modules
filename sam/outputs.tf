#
# Service Account Outputs
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
#

output "service_account_email" {
  value = google_service_account.sam.email
}

output "admin_sdk_service_account_emails" {
  value = google_service_account.sam_admin_sdk.*.email
}
