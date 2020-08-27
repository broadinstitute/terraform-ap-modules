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
    # TODO: remove cloudsql.client deprecated by separate service account once we have migrated
    # existing deployments.
    "roles/cloudsql.client",
    # Stairway publishes and subscribes to pubsub.
    "roles/pubsub.publisher",
    "roles/pubsub.subscriber",
    # Allow the creation and exporting of monitoring metrics.
    "roles/monitoring.editor"
  ]
}

# The main service account for the Janitor service app.
resource "google_service_account" "app" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
}

resource "google_project_iam_member" "app_roles" {
  count = var.enable ? length(local.app_sa_roles) : 0

  provider = google.target
  project  = var.google_project
  role     = local.app_sa_roles[count.index]
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

data "google_project" "project" {
}

output "project_number" {
  value = data.google_project.project.number
}

// Pubsub creates a SA account for each project: service-project-number@gcp-sa-pubsub.iam.gserviceaccount.com for
// deal lette queue message management.
// See https://cloud.google.com/pubsub/docs/dead-letter-topics#granting_forwarding_permissions.
data "google_service_account" "project_pubsub_sa" {
  account_id = join(["service-", data.google_project.project.number]
}