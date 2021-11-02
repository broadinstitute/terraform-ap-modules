## Workload Identity Resources for TestRunner Dashboard

# Workload Identity service account for TesRunner Dashboard operations.
# This service account allow pool identities to access resources in Google Cloud projects,
# e.g. by granting roles/iam.serviceAccountUser role to this service account.
resource "google_service_account" "testrunner_dashboard_workload_sa" {
  count        = var.enable_dashboard ? 1 : 0
  provider     = google.target
  project      = var.google_project
  account_id   = "${local.dashboardservice}-workload-${local.owner}"
  display_name = "${local.dashboardservice}-workload-${local.owner}"
  description  = "The Workload Identity IAM Service Account that the TestRunner Dashboard Kubernetes Service Account can impersonate"
}

# Allow the Kubernetes service account to impersonate the Google service account
# by creating an IAM policy binding between the two. This binding allows the
# Kubernetes Service account to act as the Google service account.
#
# Non-authoritative. Updates the IAM policy to grant roles/iam.workloadIdentityUser role to the workload identity pool associated with the Kubernetes service account.
# Other members for the role for the service account are preserved.
resource "google_service_account_iam_member" "testrunner_dashboard_workload_identity_iam_role" {
  count              = var.enable_dashboard ? 1 : 0
  service_account_id = google_service_account.testrunner_dashboard_workload_sa[0].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.google_project}.svc.id.goog[${var.dashboard_namespace}/${local.dashboardservice}-sa]"
}
