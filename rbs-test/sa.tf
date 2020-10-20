# The service account which has editor permission.
resource "google_service_account" "rbs_test_editor" {
  provider     = google.target
  project      = var.google_project
  account_id   = "rbs-test-editor"
  display_name = "rbs-test-editor"
}
# The service account which has viewer permission.
resource "google_service_account" "rbs_test_viewer" {
  provider     = google.target
  project      = var.google_project
  account_id   = "rbs-test-viewer"
  display_name = "rbs-test-viewer"
}
