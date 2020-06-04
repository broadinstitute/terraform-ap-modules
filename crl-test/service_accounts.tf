# Service account for the CRL Integration tests to use.
resource "google_service_account" "crl" {
  project = google_project.project.name
  account_id = "crl-test"
  display_name = "crl-test"
}

locals {
  roles = [
    # Roles needed as a part of CRL functionality.
    "roles/cloudtrace.agent",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    # Roles used in integration testing.
    "roles/storage.admin",
    "roles/bigquery.admin",
  ]
}

resource "google_project_iam_member" "crl" {
  count = length(local.roles)
  project = google_project.project.name
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.crl.email}"
}
