# Main service account for the Sam service.
resource "google_service_account" "sam" {
  count = var.enable && contains(["preview_shared"], var.env_type) ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.owner}-sam"
  display_name = "${local.owner}-sam"
}

# Additional service accounts for Sam to use to manage GSuite admin group actions.
# No GCP roles required for these service accounts. GSuite authority is added through a manual process.
resource "google_service_account" "sam_admin_sdk" {
  count = var.enable && contains(["preview_shared"], var.env_type) ? var.num_admin_sdk_service_accounts : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.owner}-sam-sdk-${count.index}"
  display_name = "${local.owner}-sam-sdk-${count.index}"
}

locals {
  # Roles to give Sam on its own Google project.
  roles = [
    "roles/iam.serviceAccountUser",
    "roles/cloudtrace.agent",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/cloudkms.admin",
    "roles/cloudsql.client",
    "roles/datastore.user",
    "roles/pubsub.admin",
    "roles/storage.admin"
  ]
}

resource "google_project_iam_member" "sam" {
  count = var.enable && contains(["preview_shared"], var.env_type) ? length(local.roles) : 0

  provider = google.target
  project  = var.google_project
  role     = local.roles[count.index]
  member   = "serviceAccount:${google_service_account.sam[0].email}"
}
