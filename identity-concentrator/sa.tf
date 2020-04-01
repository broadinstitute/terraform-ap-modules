resource "google_service_account" "app" {
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
}
resource "google_project_iam_member" "app_roles" {
  count = length(local.sa_roles)

  project = var.google_project
  role    = local.sa_roles[count.index]
  member  = "serviceAccount:${google_service_account.app.email}"
}
