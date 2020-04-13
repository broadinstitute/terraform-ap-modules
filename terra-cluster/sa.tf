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

# Service account for the k8s node pool.
resource "google_service_account" "node_pool" {
  project      = var.google_project
  account_id   = "${local.owner}-node-pool"
  display_name = "${local.owner}-node-pool"
}

locals {
  # Roles needed for the node pool service account to run a GKE cluster.
  node_pool_gke_roles = [
    "monitoring.viewer",
    "monitoring.metricWriter",
    "logging.logWriter",
    # Google Container Registry read access.
    "roles/storage.objectViewer"
  ]
}

resource "google_project_iam_member" "node_pool_gke" {
  count   = length(local.node_pool_gke_roles)
  project = var.google_project
  role    = element(local.node_pool_gke_roles, count.index)
  member  = "serviceAccount:${google_service_account.node_pool.email}"
}

# Read and pull images from other_gcr_projects Google Container Registries.
resource "google_project_iam_member" "node_pool" {
  count   = length(var.other_gcr_projects)
  project = element(var.other_gcr_projects, count.index)
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.node_pool.email}"
}
