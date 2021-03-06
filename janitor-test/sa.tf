locals {
  folder_roles = [
    "roles/editor",
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter",
  ]
}

# The service account used to access cloud resources in test.
resource "google_service_account" "janitor_test" {
  provider     = google.target
  project      = var.google_project
  account_id   = "janitor-test-resource-access"
  display_name = "janitor-test-resource-access"
}

# Grant this SA Account permission to create/modify resources in test.
resource "google_folder_iam_member" "janitor_test_folder_roles" {
  count    = length(local.folder_roles)
  provider = google.target
  folder   = var.folder_id
  role     = local.folder_roles[count.index]
  member   = "serviceAccount:${google_service_account.janitor_test.email}"
}
