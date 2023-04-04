data "google_service_account" "leonardo_service_account" {
  count      = var.enable && var.enable_workload_identity ? 1 : 0
  project    = var.google_project
  account_id = var.service_accounts["leonardo"]
}

resource "google_service_account_iam_member" "leonardo_workload_identity" {
  count              = var.enable && var.enable_workload_identity ? 1 : 0
  provider           = google.target
  service_account_id = data.google_service_account.leonardo_service_account[0].unique_id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.google_project}.svc.id.goog[${local.namespace}/${var.kubernetes_sa_name}]"
}
