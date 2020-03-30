# Main service account for the sam service.
resource "google_service_account" "sam" {
  project = var.google_project
  account_id = "${var.gcp_name_prefix}-sam"
  display_name = "${var.gcp_name_prefix}-sam"
}

# Additional service accounts for Sam to use to manage GSuite admin group actions.
# No GCP roles required for these service accounts. GSuite authority is added through a manual process.
resource "google_service_account" "sam_admin_sdk" {
  count = var.num_admin_sdk_service_accounts
  project = var.google_project
  account_id = "${var.gcp_name_prefix}-sam-admin-sdk-sa-${count.index}"
  display_name = "${var.gcp_name_prefix}-sam-admin-sdk-sa-${count.index}"
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
  ]
}

resource "google_project_iam_member" "sam" {
  count = length(local.roles)
  project = var.google_project
  role = local.roles[count.index]
  member = "serviceAccount:${google_service_account.sam}"
}

resource "google_project_iam_member" "sam_classic" {
  count = length(local.classic_roles)
  project = var.classic_storage_google_project
  role = local.classic_roles[count.index]
  member = "serviceAccount:${google_service_account.sam}"
}

# Grant sam service account access to shared bucket storing pet service account keys.
resource "google_storage_bucket_iam_member" "google_key_cache" {
  bucket = var.google_key_cache_bucket.name
  project = var.google_key_cache_bucket.project
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.sam.email}"
}
