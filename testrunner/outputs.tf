#
# Test Runner Email
#
output "testrunner_email" {
  value = google_service_account.testrunner_service_account[0].email
}
