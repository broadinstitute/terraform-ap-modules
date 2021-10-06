#
# Service account ID Outputs
#

output "testrunner_sa_id" {
  value       = google_service_account.testrunner_sa[0].account_id
  description = "TestRunner service account id"
}

output "testrunner_cf_deployer_sa_id" {
  value       = google_service_account.testrunner_cf_deployer_sa[0].account_id
  description = "TestRunner Cloud Functions deployer service account id"
}

output "testrunner_streamer_sa_id" {
  value       = google_service_account.testrunner_streamer_sa[0].account_id
  description = "TestRunner streamer service account id"
}

output "testrunner_dashboard_sa_id" {
  value       = var.enable_dashboard ? google_service_account.testrunner_dashbaord_sa[0].account_id : null
  description = "TestRunner Dashboard Workload Identity service account id"
}
