# One Test Runner Service account for uploading results files to a bucket
resource "google_service_account" "sa_testrunner" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "testrunner-sa"
  display_name = "testrunner-sa"
}

# Service account for the "streamer" cloud function
resource "google_service_account" "sa_bq_streamer" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-streamer"
  display_name = "${local.service}-${local.owner}-streamer"
}

# Service account for the "file-mover" cloud function.
resource "google_service_account" "sa_filemover" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-filemover"
  display_name = "${local.service}-${local.owner}-filemover"
}
