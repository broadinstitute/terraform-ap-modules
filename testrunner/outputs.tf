output "testrunner_sa_email" {
  value       = google_service_account.testrunner_service_account.email
  description = "Google service account email"
}

output "testrunner_sa_id" {
  value       = google_service_account.testrunner_service_account.account_id
  description = "Google service account id"
}
