resource "google_service_account" "sqlproxy" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-sqlproxy"
  display_name = "${local.service}-${local.owner}-sqlproxy"
}
resource "google_project_iam_member" "app_roles" {
  provider = google.target
  project  = var.google_project
  role     = "roles/cloudsql.client"
  member   = "serviceAccount:${google_service_account.sqlproxy[0].email}"
}

resource "google_service_account" "cloud_trace" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-cloud-trace"
  display_name = "${local.service}-${local.owner}-cloud-trace"
}

resource "google_project_iam_member" "cloud_trace_roles" {
  count = var.enable ? 1 : 0

  provider = google.target
  project  = var.google_project
  role     = "roles/cloudtrace.admin"
  member   = "serviceAccount:${google_service_account.cloud_trace[0].email}"
}
