#
# Service account ID Outputs
#

output "sa_testrunner_id" {
  value       = google_service_account.sa_testrunner[0].account_id
  description = "TestRunner SA ID"
}

output "sa_bq_streamer_id" {
  value       = google_service_account.sa_bq_streamer[0].account_id
  description = "bq_streamer SA ID"
}

output "sa_filemover_id" {
  value       = google_service_account.sa_filemover[0].account_id
  description = "Filemover SA ID"
}
