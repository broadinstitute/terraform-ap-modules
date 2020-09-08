# Service accounts for the CRL Integration tests to use.
resource "google_service_account" "crl_test_admin" {
  project      = google_project.project.name
  account_id   = "crl-test-admin"
  display_name = "crl-test-admin"
}

resource "google_service_account" "crl_test_user" {
  project      = google_project.project.name
  account_id   = "crl-test-user"
  display_name = "crl-test-user"
}

locals {
  roles = [
    # Roles needed as a part of CRL functionality.
    "roles/cloudtrace.agent",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    # Roles used in integration testing.
    "roles/billing.user",
    "roles/storage.admin",
    "roles/bigquery.admin",
  ]

  # Roles used to manage projects for integration testing.
  folder_roles = [
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter",
  ]
}

resource "google_project_iam_member" "crl_test_admin" {
  count   = length(local.roles)
  project = google_project.project.name
  role    = local.roles[count.index]
  member  = "serviceAccount:${google_service_account.crl_test_admin.email}"
}

resource "google_folder_iam_member" "app_folder_roles" {
  count = length(local.folder_roles)
  provider = google.target
  folder  = google_folder.test_resource_container.id
  role     = local.folder_roles[count.index]
  member   = "serviceAccount:${google_service_account.crl_test_admin.email}"
}
