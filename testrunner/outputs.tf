#
# Service account ID Outputs
#

output "testrunner_sa_id" {
  value       = join(" ", google_service_account.testrunner_sa.*.account_id)
  description = "TestRunner service account id"
}

output "testrunner_cf_deployer_sa_id" {
  value       = join(" ", google_service_account.testrunner_cf_deployer_sa.*.account_id)
  description = "TestRunner Cloud Functions deployer service account id"
}

output "testrunner_streamer_sa_id" {
  value       = join(" ", google_service_account.testrunner_streamer_sa.*.account_id)
  description = "TestRunner streamer service account id"
}

output "testrunner_dashboard_sa_id" {
  value       = join(" ", google_service_account.testrunner_dashboard_workload_sa.*.account_id)
  description = "TestRunner Dashboard Workload Identity service account id"
}
