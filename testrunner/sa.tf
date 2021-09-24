## TestRunner Service Accounts

# Main service account (assume this is for general operations?)
resource "google_service_account" "testrunner_sa" {
  count         = var.enable ? 1 : 0
  provider      = google.target
  project       = var.google_project
  account_id    = "${local.service}-${local.owner}"
  display_name  = "${local.service}-${local.owner}"
  description   = "The IAM Service Account for TestRunner"
}

# Service account for deploying the TestRunner-related cloud functions.
resource "google_service_account" "testrunner_cf_deployer_sa" {
  count         = var.enable ? 1 : 0
  provider      = google.target
  project       = var.google_project
  account_id    = "${local.service}-${local.owner}-cf-deployer"
  display_name  = "${local.service}-${local.owner}-cf-deployer"
  description   = "The Service Account for deploying TestRunner Cloud Functions"
}

# Service account for the TestRunner "streamer" cloud function.
# Cloud functions running as this SA has permissions to
# 1) Subscribe to the relevant PubSub event (object-finalize) generated by the bucket that the Cloud function listens on
# 2) Open a channel / input stream to the file object in the bucket.
# 3) Stream data to BigQuery.
resource "google_service_account" "testrunner_streamer_sa" {
  count         = var.enable ? 1 : 0
  provider      = google.target
  project       = var.google_project
  account_id    = "${local.service}-${local.owner}-streamer"
  display_name  = "${local.service}-${local.owner}-streamer"
  description   = "The Service Account for TestRunner Streamer Cloud Functions"
}

data "google_app_engine_default_service_account" "default_appspot_sa" {
}

## TestRunner IAM Roles

# Notes:
# 1.  Grants both TestRunner and TestRunner Streamer SAs the ability to stream to BigQuery.
#     Right now, there is a redundancy here for backward compatibility to older versions of TestRunner.
#     Eventually we will remove the binding for TestRunner SA and use the Streamer SA binding only.
#
# 2.  Permission for deployer SA to manage Cloud Functions. N.B. we don't create
#     the Google project used for the deployment of TestRunner Cloud Functions,
#     so we apply the permission to that Google project here instead of in a
#     google-project.tf module
#
# 3.  Grants the deployer SA the ability to use TestRunner streamer SA.
#     This allows, for example, the Cloud Function deployer SA to stand up the relevant Cloud Function as streamer.
#
# 4.  Grants the deployer service account the ability to act as
#     <project-id>@appspot.gserviceaccount.com

resource "google_project_iam_member" "testrunner_sa_project_iam_role" {
  count   = length(var.testrunner_sa_project_iam_roles)
  project = var.google_project
  role    = element(var.testrunner_sa_project_iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.testrunner_sa[0].email}"
}

resource "google_project_iam_member" "testrunner_cf_deployer_sa_project_iam_role" {
  count   = length(var.testrunner_cf_deployer_sa_project_iam_roles)
  project = var.google_project
  role    = element(var.testrunner_cf_deployer_sa_project_iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.testrunner_cf_deployer_sa[0].email}"
}

resource "google_service_account_iam_member" "testrunner_cf_deployer_sa_runas_default_appspot_sa_service_account_iam_role" {
  service_account_id  = data.google_app_engine_default_service_account.default_appspot_sa.name
  role                = "roles/iam.serviceAccountUser"
  member              = "serviceAccount:${google_service_account.testrunner_cf_deployer_sa[0].email}"
}

resource "google_service_account_iam_member" "testrunner_cf_deployer_sa_runas_testrunner_streamer_sa_service_account_iam_role" {
  service_account_id  = google_service_account.testrunner_streamer_sa[0].name
  role                = "roles/iam.serviceAccountUser"
  member              = "serviceAccount:${google_service_account.testrunner_cf_deployer_sa[0].email}"
}

resource "google_project_iam_member" "testrunner_streamer_sa_project_iam_role" {
  count   = length(var.testrunner_streamer_sa_project_iam_roles)
  project = var.google_project
  role    = element(var.testrunner_streamer_sa_project_iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.testrunner_streamer_sa[0].email}"
}

## The following entities were added on 24 Sep 2021 as part of a temporary
## workaround to address the IAM storage.admin role SA membership issue that
## manifested as part of QA-1485 and QA-1526. See JIRA issue DDO-1542 for details.
#
# These variables will need to remain in this file until the following items are
# complete:
# - The changes for QA-1526 have been merged to master in terraform-ap-modules and
#   terraform-ap-deployments.
# - The changes required to manage these non-TestRunner entities have been moved
#   to a common IAM module.

data "google_service_account" "firecloud_sa" {
  account_id = var.firecloud_sa_name
}

data "google_service_account" "leonardo_sa" {
  account_id = var.leonardo_sa_name
}

data "google_service_account" "sam_sa" {
  account_id = var.sam_sa_name
}

resource "google_project_iam_member" "firecloud_sa_project_iam_role" {
  count   = length(var.firecloud_sa_project_iam_roles)
  project = var.google_project
  role    = element(var.firecloud_sa_project_iam_roles, count.index)
  member  = "serviceAccount:${data.google_service_account.firecloud_sa.email}"
}

resource "google_project_iam_member" "leonardo_sa_project_iam_role" {
  count   = length(var.leonardo_sa_project_iam_roles)
  project = var.google_project
  role    = element(var.leonardo_sa_project_iam_roles, count.index)
  member  = "serviceAccount:${data.google_service_account.leonardo_sa.email}"
}

resource "google_project_iam_member" "sam_sa_project_iam_role" {
  count   = length(var.sam_sa_project_iam_roles)
  project = var.google_project
  role    = element(var.sam_sa_project_iam_roles, count.index)
  member  = "serviceAccount:${data.google_service_account.sam_sa.email}"
}
