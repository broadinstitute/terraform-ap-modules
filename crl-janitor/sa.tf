resource "google_service_account" "app" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
}

resource "google_project_iam_member" "app_roles" {
  count = var.enable ? length(local.sa_roles) : 0

  provider = google.target
  project  = var.google_project
  role     = local.sa_roles[count.index]
  member   = "serviceAccount:${google_service_account.app[0].email}"
}

# Grant Janitor App Service Account editor permission in folder level permission to cleanup resources.
resource "google_folder_iam_member" "app_folder_roles" {
  // Skip if google_folder variable is not present.
  count = var.enable && (var.google_folder_id != "") ? 1 : 0

  provider = google.target
  folder  = var.google_folder_id
  role     = "roles/editor"
  member   = "serviceAccount:${google_service_account.app[0].email}"
}

# The service account to be able to access Janitor service.
# All services which want to access Janitor would need to use this service account secrete.
resource "google_service_account" "client" {
  count = var.enable ? 1 : 0

  provider     = google.target
  account_id   = "${local.service}-client-${local.owner}"
  display_name = "${local.service}-client-${local.owner}"
}
