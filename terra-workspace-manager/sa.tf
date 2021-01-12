# The service account for the cloudsql proxy.
resource "google_service_account" "sqlproxy" {
  count = var.enable && contains(["default"], var.env_type) ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-sqlproxy"
  display_name = "${local.service}-${local.owner}-sqlproxy"
}
resource "google_project_iam_member" "sqlproxy" {
  count = var.enable && contains(["default"], var.env_type) ? 1 : 0

  provider = google.target
  project  = var.google_project
  role     = "roles/cloudsql.client"
  member   = "serviceAccount:${google_service_account.sqlproxy[0].email}"
}

locals {
  app_sa_roles = [
    # Allow exporting metrics, profiling, and tracing for monitoring.
    "roles/monitoring.editor",
    "roles/cloudprofiler.agent",
    "roles/cloudtrace.agent",
  ]

  # Roles used to manage created workspace projects.
  # TODO(PF-156): Once WM uses Resource Buffer Service, we no longer need permissions to create projects.
  app_folder_roles = [
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter",
  ]
}

resource "google_service_account" "app" {
  count = var.enable && contains(["default", "preview_shared"], var.env_type) ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
}

resource "google_project_iam_member" "app" {
  count    = var.enable && contains(["default", "preview_shared"], var.env_type) ? length(local.app_sa_roles) : 0
  provider = google.target
  project  = var.google_project
  role     = local.app_sa_roles[count.index]
  member   = "serviceAccount:${google_service_account.app[0].email}"
}
resource "google_folder_iam_member" "app" {
  count    = local.create_folder ? length(local.app_folder_roles) : 0
  provider = google.target
  folder   = google_folder.workspace_project_folder[0].id
  role     = local.app_folder_roles[count.index]
  member   = "serviceAccount:${google_service_account.app[0].email}"
}
resource "google_billing_account_iam_member" "app" {
  count              = var.enable && contains(["default", "preview_shared"], var.env_type) ? length(var.billing_account_ids) : 0
  billing_account_id = var.billing_account_ids[count.index]
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.app[0].email}"
}
