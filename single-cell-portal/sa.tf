resource "google_service_account" "app" {
  provider     = google.target

  count        = var.create_sa ? 1 : 0

  account_id   = local.app_sa_name
  display_name = local.app_sa_name
  project      = var.google_project
}
resource "google_project_iam_member" "app" {
  provider     = google.target

  count   = var.create_sa ? length(var.app_sa_roles) : 0

  project = var.google_project
  role    = element(var.app_sa_roles, count.index)
  member  = "serviceAccount:${google_service_account.app[0].email}"
}

resource "google_service_account" "app_read" {
  provider     = google.target

  count        = var.create_sa ? 1 : 0

  account_id   = local.app_read_sa_name
  display_name = local.app_read_sa_name
  project      = var.google_project
}
resource "google_project_iam_member" "app_read" {
  provider     = google.target

  count   = var.create_sa ? length(var.app_read_sa_roles) : 0

  project = var.google_project
  role    = element(var.app_read_sa_roles, count.index)
  member  = "serviceAccount:${google_service_account.app_read[0].email}"
}
