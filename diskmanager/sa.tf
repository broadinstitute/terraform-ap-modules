resource "google_service_account" "diskmanager_sa" {
  provider     = google.target
  project      = var.google_project
  account_id   = "diskmanager-${local.owner}"
  display_name = "diskmanager-${local.owner}"
}

resource "google_project_iam_custom_role" "diskmanager_sa_custom_role" {
  provider = google.target
  project     = var.google_project
  role_id     = "diskmanagerRole"
  title       = "Diskmanager Custom Role"
  description = "Custom role for Diskmanager, managed by DevOps Atlantis `diskmanager`"
  permissions = [
    # As of 1/13/22 IAM Recommender across all environments
    # Replaces Compute Storage Admin
    "compute.disks.list",
    "compute.resourcePolicies.get"
  ]
}

resource "google_project_iam_binding" "diskmanager_sa_role" {
  provider = google.target
  project  = var.google_project

  role = google_project_iam_custom_role.diskmanager_sa_custom_role.id
  members = [
    "serviceAccount:${google_service_account.diskmanager_sa.email}"
  ]
}
