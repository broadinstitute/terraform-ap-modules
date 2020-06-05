# Service accounts for the CRL Integration tests to use.
resource "google_service_account" "crl_admin" {
  project = google_project.project.name
  account_id = "crl-test-admin"
  display_name = "crl-test-admin"
}

resource "google_service_account" "crl-user" {
  project = google_project.project.name
  account_id = "crl-test-user"
  display_name = "crl-test-user"
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

resource "google_project_iam_member" "crl-admin" {
  count = length(local.roles)
  project = google_project.project.name
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.crl_admin.email}"
}

resource "google_project_iam_member" "crl-user" {
  count = length(local.roles)
  project = google_project.project.name
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.crl_user.email}"
}
