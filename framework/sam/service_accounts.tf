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
  for_each = local.roles
  project = var.google_project
  role = each.value
  member = "serviceAccount:${google_service_account.sam}"
}

resource "google_project_iam_member" "sam_classic" {
  for_each = local.classic_roles
  project = var.classic_storage_google_project
  role = each.value
  member = "serviceAccount:${google_service_account.sam}"
}

# Grant sam service account access to shared bucket storing pet service account keys.
resource "google_project_iam_member" "google_key_cache" {
  project = var.google_key_cache_bucket.project
  role = "roles/storage.admin"
  bucket = var.google_key_cache_bucket.name
  member = "serviceAccount:${google_service_account.sam.email}"
}

resource "google_service_account_key" "sam" {
  service_account_id = "${google_service_account.sam.name}"
}

resource "google_service_account_key" "sam_admin_sdk" {
  count        = "${var.num_admin_sdk_service_accounts}"
  service_account_id = "${element(google_service_account.sam_admin_sdk.*.name, count.index)}"
}
