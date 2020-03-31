# Main service account for the sam service.
# Note that Sam's service account is on the classic storage google project. This is to make it easier for Sam to use the
# right project for storage with all of its current uses of service accounts. That may not be a compelling reason in the
# future.
resource "google_service_account" "sam" {
  project = var.classic_storage_google_project
  account_id = "${var.gcp_name_prefix}-sam"
  display_name = "${var.gcp_name_prefix}-sam"
}

# Additional service accounts for Sam to use to manage GSuite admin group actions.
# No GCP roles required for these service accounts. GSuite authority is added through a manual process.
resource "google_service_account" "sam_admin_sdk" {
  count = var.num_admin_sdk_service_accounts
  project = var.google_project
  account_id = "${var.gcp_name_prefix}-sam-sdk-${count.index}"
  display_name = "${var.gcp_name_prefix}-sam-sdk-${count.index}"
}

locals {
  # Roles to give Sam on its own Google project.
  roles = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/cloudtrace.agent"
  ]
  # Roles to give Sam on the classic Google project.
  classic_roles = [
    "roles/pubsub.editor",
    "roles/datastore.user",
    "roles/storage.admin",
  ]
}

resource "google_project_iam_member" "sam" {
  count = length(local.roles)
  project = var.google_project
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.sam.email}"
}

resource "google_project_iam_member" "sam_classic" {
  count = length(local.classic_roles)
  project = var.classic_storage_google_project
  role = local.classic_roles[count.index]
  member = "serviceAccount:${google_service_account.sam.email}"
}
