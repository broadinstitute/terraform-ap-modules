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
  # TODO(PF-156): Once WM uses RBS, we no longer need permissions to create projects.
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

resource "google_billing_account_iam_member" "crl_test_admin" {
  count              = var.enable && contains(["default", "preview_shared"], var.env_type) ? length(var.billing_account_ids) : 0
  billing_account_id = var.billing_account_ids[count.index]
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.app.email}"
}

resource "google_folder_iam_member" "app_folder_roles" {
  count    = var.enable && contains(["default", "preview_shared"], var.env_type) ? length(local.app_folder_roles) : 0
  provider = google.target
  folder   = google_folder.workspace_project_folder.id
  role     = local.app_folder_roles[count.index]
  member   = "serviceAccount:${google_service_account.app.email}"
}

# TODO(wchamber): Remove the cloud_trace SA in favor of the single "app" SA.
resource "google_service_account" "cloud_trace" {
  count = var.enable && contains(["default", "preview_shared"], var.env_type) ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-cloud-trace"
  display_name = "${local.service}-${local.owner}-cloud-trace"
}

resource "google_project_iam_member" "cloud_trace" {
  count = var.enable && contains(["default", "preview_shared"], var.env_type) ? 1 : 0

  provider = google.target
  project  = var.google_project
  role     = "roles/cloudtrace.admin"
  member   = "serviceAccount:${google_service_account.cloud_trace[0].email}"
}
