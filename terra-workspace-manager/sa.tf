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
    "roles/cloudprofiler.agent", # Profiling
    "roles/cloudtrace.agent", # Tracing for monitoring
    "roles/monitoring.editor", # Exporting metrics
    "roles/pubsub.editor", # Creating, publishing & subscribing pub/sub topics for multi-instance Stairway.
  ]

  # For permissions from normally-admin roles that WSM needs for specific functionality
  app_sa_custom_role_permissions = [
    # For GCS Bucket Clone operations (replaces Storage Transfer Admin)
    #   As of 1/18/22, "this functionality is only used by Verily services, not Terra UI (yet)",
    #   so it isn't currently used everywhere, but "at some point we expect this will be used in 
    #   all environments"
    #   https://broadinstitute.slack.com/archives/C02LMB1PQ6R/p1642541948003200
    "storagetransfer.jobs.create",
    "storagetransfer.jobs.delete",
    "storagetransfer.jobs.get",
    "storagetransfer.operations.get",
    "storagetransfer.projects.getServiceAccount"
  ]

  # Roles used to manage created workspace projects.
  app_folder_roles = [
    "roles/owner",
  ]

  folder_ids_and_roles = [
  for pair in setproduct(local.app_folder_roles, var.workspace_project_folder_ids) : {
    folder_role = pair[0]
    folder_id = pair[1]
  }]
}

resource "google_project_iam_custom_role" "app_sa_custom_role" {
  count = var.enable && contains(["default", "preview_shared"], var.env_type) ? 1 : 0

  provider = google.target
  project = var.google_project
  role_id = "${local.service}${title(local.owner)}CustomRole"
  title = "${local.service}-${local.owner} Custom Role"
  description = "Custom role for ${local.service} ${local.owner}, managed by DevOps Atlantis `terra-env`"
  permissions = local.app_sa_custom_role_permissions
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

resource "google_project_iam_member" "app_custom_role_membership" {
  count    = var.enable && contains(["default", "preview_shared"], var.env_type) ? 1 : 0
  provider = google.target
  project  = var.google_project
  role     = google_project_iam_custom_role.app_sa_custom_role[0].id
  member   = "serviceAccount:${google_service_account.app[0].email}"
}

# Grant WorkspaceManager Service App Service Account permission to modify resource in folder.
resource "google_folder_iam_member" "app_folder_roles" {
  count = var.enable ? length(local.folder_ids_and_roles): 0

  provider = google.target
  folder  = local.folder_ids_and_roles[count.index].folder_id
  role     = local.folder_ids_and_roles[count.index].folder_role
  member   = "serviceAccount:${google_service_account.app[0].email}"
}
resource "google_billing_account_iam_member" "app" {
  count              = var.enable && contains(["default", "preview_shared"], var.env_type) ? length(var.billing_account_ids) : 0
  billing_account_id = var.billing_account_ids[count.index]
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.app[0].email}"
}
