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
  count   = length(var.ci_sa_roles)
  project = var.google_project
  role    = element(var.ci_sa_roles, count.index)
  member  = "serviceAccount:${google_service_account.ci.email}"
}
