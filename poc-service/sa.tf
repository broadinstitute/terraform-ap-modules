resource "google_service_account" "app" {
  project      = var.google_project
  account_id   = "${var.service}-${local.owner}"
  display_name = "${var.service}-${local.owner}"
}
resource "google_project_iam_member" "app_roles" {
  count   = length(var.sa_roles)

  project = var.google_project
  role    = var.sa_roles[count.index]
  member  = "serviceAccount:${google_service_account.app.email}"
}
