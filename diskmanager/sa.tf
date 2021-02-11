resource "google_service_account" "diskmanager_sa" {
  provider     = google.target
  project      = var.google_project
  account_id   = "diskmanager-${local.owner}"
  display_name = "diskmanager-${local.owner}"
}

resource "google_project_iam_binding" "diskmanager_sa_role" {
  provider = google.target
  project  = var.google_project

  role = "roles/compute.storageAdmin"
  members = [
    "serviceAccount:${google_service_account.diskmanager_sa.email}"
  ]
}
