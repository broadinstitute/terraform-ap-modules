#
# Service Accounts
#

# CI/GitHub Actions Service Account
resource "google_service_account" "ci" {
  project      = var.google_project
  account_id   = "${local.owner}-ci-sa"
  display_name = "${local.owner}-ci-sa"
}
resource "google_project_iam_member" "ci" {
  count   = length(local.ci_sa_roles)
  project = var.google_project
  role    = element(local.ci_sa_roles, count.index)
  member  = "serviceAccount:${google_service_account.ci.email}"
}

# Broad DSP Google Container Registry access.
resource "google_project_iam_member" "ci" {
  project = "broad-dsp-gcr-public"
  # Read and pull images.
  role = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.ci.email}"
}
