# The service account for the cloudsql proxy.
resource "google_service_account" "sqlproxy" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-sqlproxy"
  display_name = "${local.service}-${local.owner}-sqlproxy"
}
resource "google_project_iam_member" "sqlproxy_role" {
  count = var.enable ? 1 : 0

  provider = google.target
  project  = var.google_project
  role     = "roles/cloudsql.client"
  member   = "serviceAccount:${google_service_account.sqlproxy[0].email}"
}

locals {
  app_sa_roles = [
    # Allow creating project.


    # Allow exporting metrics, profiling, and tracing for monitoring.
    "roles/monitoring.editor",
    "roles/cloudprofiler.agent",
    "roles/cloudtrace.agent",
  ]

  # Roles used to manage projects for integration testing.
  app_folder_roles = [
    # Allow creating project.
    "roles/resourcemanager.projectCreator",
  ]
}

# The main service account for the Terra RBS service app.
resource "google_service_account" "app" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
}

# Grant Terra RBS App Service Account editor permission to create resources.
# TBD: This may change to organization/folder level permission depends on the Rawls integration
resource "google_project_iam_member" "app_roles" {
  count = var.enable ? length(local.app_sa_roles) : 0

  provider = google.target
  project  = var.google_project
  role     = local.app_sa_roles[count.index]
  member   = "serviceAccount:${google_service_account.app[0].email}"
}


# Grant Terra RBS App Service Account permission to modify resource in folder.
resource "google_folder_iam_member" "app_folder_roles" {
  // Skip if google_folder variable is not present.
  count = var.enable && (var.google_folder_id != "") ? length(local.app_folder_roles) : 0

  provider = google.target
  folder  = var.google_folder_id
  role     = local.app_folder_roles[count.index]
  member   = "serviceAccount:${google_service_account.app[0].email}"
}


