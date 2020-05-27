resource "google_project" "project" {
  provider = "google.target"
  name                  = "${var.google_project}"
  project_id            = "${var.google_project}"
  billing_account       = "${var.billing_account_id}"
  folder_id             = "${var.folder_id}"
  auto_create_network   = false
}
