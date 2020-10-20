#
# Service Account Outputs
# User of this module is expected to create the google_service_account_key resource and store the key for the
# output service accounts.
#
output "service_account_editor_email" {
  value       = google_service_account.rbs_test_editor.email
  description = "Editor permission Google service account email in RBS test"
}
output "service_account_viewer_email" {
  value       = google_service_account.rbs_test_viewer.email
  description = "Viewer permission Google service account email in RBS test"
}

