# Service accounts for the CRL Integration tests to use.
resource "google_service_account" "crl-1" {
  project = google_project.project.name
  account_id = "crl-test-1"
  display_name = "crl-test-1"
}

resource "google_service_account" "crl-2" {
  project = google_project.project.name
  account_id = "crl-test-2"
  display_name = "crl-test-2"
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

resource "google_project_iam_member" "crl-1" {
  count = length(local.roles)
  project = google_project.project.name
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.crl-1.email}"
}

resource "google_project_iam_member" "crl-2" {
  count = length(local.roles)
  project = google_project.project.name
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.crl-2.email}"
}