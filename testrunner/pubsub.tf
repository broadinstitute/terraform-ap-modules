# Pub/Sub topics and subscriptions for TestRunner

# Pubsub topic for TestRunner results bucket's Storage Object Events.
resource "google_pubsub_topic" "testrunner_results_bucket_topic" {
  count    = var.enable ? 1 : 0
  provider = google.target
  project  = var.google_project
  name     = "testrunner-results-bucket-topic"
}

# N.B. no need to create subscriptions; subscriptions are automatically created when the relevant
# Cloud Functions are deployed.

# automatic SA for this project: https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account
data "google_storage_project_service_account" "gsp_automatic_sa" {
  count    = var.enable ? 1 : 0
  provider = google.target
  project  = var.google_project
}

# permission for automatic SA to publish to source topic
resource "google_pubsub_topic_iam_member" "gsp_automatic_sa_testrunner_results_bucket_pubsub_topic_publish_iam_role" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.testrunner_results_bucket_topic[0].name
  count    = var.enable ? length(var.gsp_automatic_sa_testrunner_results_bucket_pubsub_topic_publish_iam_roles) : 0
  role     = element(var.gsp_automatic_sa_testrunner_results_bucket_pubsub_topic_publish_iam_roles, count.index)
  member   = "serviceAccount:${data.google_storage_project_service_account.gsp_automatic_sa[0].email_address}"
}
