#
# Service Account Outputs
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
#

output "service_account_id" {
  value = google_service_account.sam.account_id
}

output "admin_sdk_service_account_ids" {
  value = google_service_account.sam_admin_sdk.*.account_id
}
