resource "google_service_account" "testrunner_service_account" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}"
  display_name = "${local.service}-${local.owner}"
  description  = "The IAM Service Account for TestRunner"
}

# Grants both TestRunner and TestRunner Streamer SAs the ability to stream to BigQuery.
# Right now, there is a redundancy here for backward compatibility to older versions of TestRunner.
# Eventually we will remove the binding for TestRunner SA and use the Streamer SA binding only.
resource "google_project_iam_binding" "bq_job_user" {
  provider = google.target
  project  = var.google_project
  role     = "roles/bigquery.jobUser"
  members = [
    "serviceAccount:${google_service_account.testrunner_service_account[0].email}",
    "serviceAccount:${google_service_account.testrunner_streamer_sa[0].email}"
  ]
}

resource "google_project_iam_binding" "k8s_engine_viewer" {
  provider = google.target
  project  = var.google_project
  role     = "roles/container.viewer"
  members = [
    "serviceAccount:${google_service_account.testrunner_service_account[0].email}"
  ]
}

resource "google_project_iam_binding" "storage_admin" {
  project = var.google_project
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.testrunner_service_account[0].email}"
  ]
}

# Service account for deploying the TestRunner-related cloud functions.
resource "google_service_account" "testrunner_cf_deployer_sa" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-cf-deployer"
  display_name = "${local.service}-${local.owner}-cf-deployer"
  description  = "The Service Account for deploying TestRunner Cloud Functions"
}

# Permission for deployer SA to manage Cloud Functions. N.B. we don't create
# the Google project used for the deployment of TestRunner Cloud Functions,
# so we apply the permission to that Google project here instead of in a
# google-project.tf module
resource "google_project_iam_binding" "cf_admin" {
  provider = google.target
  project  = var.google_project
  role     = "roles/cloudfunctions.admin"
  members   = [
    "serviceAccount:${google_service_account.testrunner_cf_deployer_sa[0].email}"
  ]
}

# Service account for the TestRunner "streamer" cloud function.
# Cloud functions running as this SA has permissions to
# 1) Subscribe to the relevant PubSub event (object-finalize) generated by the bucket that the Cloud function listens on
# 2) Open a channel / input stream to the file object in the bucket.
# 3) Stream data to BigQuery.
resource "google_service_account" "testrunner_streamer_sa" {
  count = var.enable ? 1 : 0

  provider     = google.target
  project      = var.google_project
  account_id   = "${local.service}-${local.owner}-streamer"
  display_name = "${local.service}-${local.owner}-streamer"
  description  = "The Service Account for TestRunner Streamer Cloud Functions"
}

# Grants the deployer SA the ability to use TestRunner streamer SA.
# This allows, for example, the Cloud Function deployer SA to stand up the relevant Cloud Function as streamer.
resource "google_service_account_iam_binding" "testrunner_streamer_sa_iam" {
  service_account_id = google_service_account.testrunner_streamer_sa[0].name
  role               = "roles/iam.serviceAccountUser"
  members             = [
    "serviceAccount:${google_service_account.testrunner_cf_deployer_sa[0].email}"
  ]
}

data "google_app_engine_default_service_account" "default_appspot" {
}

# Grants the deployer service account the ability to act as
# <project-id>@appspot.gserviceaccount.com
resource "google_service_account_iam_member" "appspot_iam" {
  service_account_id = data.google_app_engine_default_service_account.default_appspot.email
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.testrunner_cf_deployer_sa[0].email}"
}
