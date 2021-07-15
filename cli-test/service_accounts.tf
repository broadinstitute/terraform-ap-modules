# Service account for the CLI tests to use to create resources in the project.
resource "google_service_account" "cli_test_admin" {
  project      = google_project.project.name
  account_id   = "cli-test-admin"
  display_name = "cli-test-admin"
}

locals {
  roles = [
    # Roles needed by CRL.
    "roles/cloudtrace.agent",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",

    # Roles used in CLI tests.
    "roles/storage.admin",
    "roles/bigquery.admin",
  ]
}

resource "google_project_iam_member" "cli_test_admin" {
  count   = length(local.roles)
  project = google_project.project.name
  role    = local.roles[count.index]
  member  = "serviceAccount:${google_service_account.cli_test_admin.email}"
}

resource "google_billing_account_iam_member" "cli_test_admin" {
  count              = var.enable_billing_user ? 1 : 0
  billing_account_id = var.billing_account_id
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.cli_test_admin.email}"
}
