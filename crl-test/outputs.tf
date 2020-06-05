#
# Service Account Outputs
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
#

output "service_account_email-1" {
  value = google_service_account.crl-1.email
}

output "service_account_email-2" {
  value = google_service_account.crl-2.email
}

