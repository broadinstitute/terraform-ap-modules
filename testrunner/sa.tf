resource "google_service_account" "testrunner_service_account" {
  count        = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
  description  = "The IAM Service Account for TestRunner"
}

resource "google_project_iam_binding" "bq_job_user" {
  provider = google.target
  project  = var.google_project
  role     = "roles/bigquery.jobUser"
  members  = [
    "serviceAccount:${google_service_account.testrunner_service_account.email}"
  ]
}

resource "google_project_iam_binding" "k8s_engine_viewer" {
  provider = google.target
  project  = var.google_project
  role     = "roles/container.viewer"
  members  = [
    "serviceAccount:${google_service_account.testrunner_service_account.email}"
  ]
}

resource "google_project_iam_binding" "storage_admin" {
  project = var.google_project
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.testrunner_service_account.email}"
  ]
}

resource "google_service_account_key" "testrunner_service_account_key" {
  service_account_id = google_service_account.testrunner_service_account[0].name
}
