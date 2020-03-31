
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
output "service_account_name" {
  value = google_service_account.sam.name
}

output "admin_sdk_service_account_names" {
  value = google_service_account.sam_admin_sdk.*.name
}
