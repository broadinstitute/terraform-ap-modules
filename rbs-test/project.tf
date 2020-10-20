resource "google_project" "project" {
  name                = var.google_project
  project_id          = var.google_project
  billing_account     = var.billing_account_id
  auto_create_network = false
}
