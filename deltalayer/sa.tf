# Service account for the "streamer" cloud function
resource "google_service_account" "sa_streamer" {
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

# Service account for deploying the cloud functions.
resource "google_service_account" "sa_deployer" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-deployer"
  display_name = "${local.service}-${local.owner}-deployer"
}

# Permission for deployer SA to manage Cloud Functions. N.B. we don't create
# the Google project used for the deployment of the Delta Layer Cloud Functions,
# so we apply the permission to that Google project here instead of in a
# google-project.tf module
resource "google_project_iam_member" "sa" {
  provider = google.target
  project  = var.google_project
  role     = "roles/cloudfunctions.admin"
  member   = "serviceAccount:${google_service_account.sa_deployer[0].email}"
}

# Grants the deployer service account the ability to launch the Cloud
# Function as the streamer service account
resource "google_service_account_iam_member" "sa_streamer_iam" {
  service_account_id = google_service_account.sa_streamer[0].name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.sa_deployer[0].email}"
}
