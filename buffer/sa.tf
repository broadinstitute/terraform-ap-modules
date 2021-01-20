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
    # Allow exporting metrics, profiling, and tracing for monitoring.
    "roles/monitoring.editor",
    "roles/cloudprofiler.agent",
    "roles/cloudtrace.agent",
  ]

  # Roles used to manage projects for integration testing.
  app_folder_roles = [
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter",
  ]
  generated_folders = local.create_folders ? [for f in google_folder.pool_folders : f.id] : []
  folder_ids_and_roles = [
    for pair in setproduct(local.app_folder_roles,
       concat(var.external_folder_ids, local.generated_folders)) : {
      folder_role = pair[0]
      folder_id = pair[1]
    }]
}

# The main service account for the Terra Resource Buffer Service service app.
resource "google_service_account" "app" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
}

# Grant Terra Resource Buffer Service App Service Account editor permission to create resources.
# TBD: This may change to organization/folder level permission depends on the Rawls integration
resource "google_project_iam_member" "app_roles" {
  count = var.enable ? length(local.app_sa_roles) : 0

  provider = google.target
  project  = var.google_project
  role     = local.app_sa_roles[count.index]
  member   = "serviceAccount:${google_service_account.app[0].email}"
}

# Grant Terra Resource Buffer Service App Service Account permission to modify resource in folder.
resource "google_folder_iam_member" "app_folder_roles" {
  // Skip if google_folder variable is not present.
  count = var.enable ? length(local.folder_ids_and_roles): 0

  provider = google.target
  folder  = local.folder_ids_and_roles[count.index].folder_id
  role     = local.folder_ids_and_roles[count.index].folder_role
  member   = "serviceAccount:${google_service_account.app[0].email}"
}

# Grant Terra Resource Buffer Service App Service Account permission use the billing accounts.
# If billing_account_ids is empty, we won't set the Resource Buffer Service SA as a billing user
resource "google_billing_account_iam_member" "app_billing_roles" {
  count              = var.enable ? length(var.billing_account_ids) : 0
  billing_account_id = var.billing_account_ids[count.index]
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.app[0].email}"
}

# The service account to be able to access Buffer service.
# All services which want to access the Buffer service would need to use this service account secret.
resource "google_service_account" "client" {
  count = var.enable ? 1 : 0

  provider     = google.target
  account_id   = "${local.service}-client-${local.owner}"
  display_name = "${local.service}-client-${local.owner}"
}
