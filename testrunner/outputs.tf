#
# Service account ID Outputs
#

output "testrunner_sa_id" {
  value       = google_service_account.testrunner_service_account[0].account_id
  description = "Google service account id"
}
