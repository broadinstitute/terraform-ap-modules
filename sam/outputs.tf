#
# Service Account Outputs
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
#

output "service_account_email" {
  value = var.enable ? google_service_account.sam[0].email : null
}

output "admin_sdk_service_account_emails" {
  value = var.enable ? google_service_account.sam_admin_sdk.*.email : null
}
