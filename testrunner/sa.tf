# One Test Runner Service account for everything
resource "google_service_account" "sa_testrunner" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "testrunner-sa"
  display_name = "testrunner-sa"
}
