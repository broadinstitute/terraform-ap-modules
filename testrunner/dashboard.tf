## Workload Identity Resources for TestRunner Dashboard

# Main service account for TesRunner dashboard operations
# IAM service accounts from other projects can grant roles/iam.serviceAccountUser role
# to this service account so that the TestRunner dashboard can access resources in other projects.
resource "google_service_account" "testrunner_dashbaord_sa" {
  count        = var.enable_dashboard ? 1 : 0
  provider     = google.target
  project      = var.google_project
  account_id   = "${local.dashboardservice}-${local.owner}"
  display_name = "${local.dashboardservice}-${local.owner}"
  description  = "The IAM Service Account that can act on behalf of the TestRunner Dashboard Kubernetes Service Account"
}

# Allow the Kubernetes service account to impersonate the Google service account
resource "google_service_account_iam_member" "testrunner_dashboard_workload_identity_iam_role" {
  count              = var.enable_dashboard ? 1 : 0
  service_account_id = google_service_account.testrunner_dashbaord_sa[0].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.google_project}.svc.id.goog[${var.dashboard_namespace}/${var.dashboard_namespace}-ksa]"
}
