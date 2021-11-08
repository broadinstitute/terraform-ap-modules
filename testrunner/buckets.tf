# Buckets for TestRunner

# "Source" bucket for storing TestRunner results: google_service_account.testrunner_service_account[0].email creates/writes, sa_filemover reads and deletes, sa_streamer reads
resource "google_storage_bucket" "testrunner-results-bucket" {
  count                       = var.enable ? 1 : 0
  name                        = "${var.google_project}-${local.service}-results"
  provider                    = google.target
  project                     = var.google_project
  location                    = var.bucket_location
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "testrunner_streamer_sa_storage_bucket_iam_role" {
  count  = var.enable ? length(var.testrunner_streamer_sa_storage_bucket_iam_roles) : 0
  bucket = google_storage_bucket.testrunner-results-bucket[0].name
  role   = element(var.testrunner_streamer_sa_storage_bucket_iam_roles, count.index)
  member = "serviceAccount:${google_service_account.testrunner_streamer_sa[0].email}"
}

# Pub/Sub notifications for object-finalize in the TestRunner results bucket.
# The TestRunner results bucket requires permissions to publish events to pub/sub topics.
# The IAM policy resource must exist before the attempt to utilise pub/sub resource.
# Here, the depends_on property tells the bucket to use the well-known, automatic Google SA
# which has been granted permissions to publish the object-finalize notifications
# to the specified pubsub topic.
resource "google_storage_notification" "testrunner-results-finalize-notification" {
  count          = var.enable ? 1 : 0
  bucket         = google_storage_bucket.testrunner-results-bucket[0].name
  provider       = google.target
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.testrunner_results_bucket_topic[0].id
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [google_pubsub_topic_iam_member.gsp_automatic_sa_testrunner_results_bucket_pubsub_topic_publish_iam_role]
}
