#
# Service account ID Outputs
#

output "sa_streamer_id" {
  value       = google_service_account.sa_testrunner[0].account_id
  description = "Streamer SA ID"
}

output "sa_filemover_id" {
  value       = google_service_account.sa_testrunner[0].account_id
  description = "File-mover SA ID"
}
