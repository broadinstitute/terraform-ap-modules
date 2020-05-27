# Service account for the CRL Integration tests to use.
resource "google_service_account" "crl" {
  project = var.google_project
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
  ]
}

resource "google_project_iam_member" "crl" {
  count = length(local.roles)
  project = var.google_project
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.crl.email}"
}
