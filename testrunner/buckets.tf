# Buckets for TestRunner

# "Source" bucket for storing TestRunner results: google_service_account.testrunner_service_account[0].email creates/writes, sa_filemover reads and deletes, sa_streamer reads
resource "google_storage_bucket" "testrunner-results-bucket" {
  name                        = "${var.google_project}-${local.service}-results"
  provider                    = google.target
  project                     = var.google_project
  location                    = var.bucket_location
  uniform_bucket_level_access = true
}

# Pub/Sub notifications for object-finalize in the TestRunner results bucket.
# The TestRunner results bucket requires permissions to publish events to pub/sub topics.
# The IAM policy resource must exist before the attempt to utilise pub/sub resource.
# Here, the depends_on property tells the bucket to use the well-known, automatic Google SA
# which has been granted permissions to publish the object-finalize notifications
# to the specified pubsub topic.
resource "google_storage_notification" "testrunner-results-finalize-notification" {
  bucket         = google_storage_bucket.testrunner-results-bucket.name
  provider       = google.target
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.testrunner_results_bucket_topic.id
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [google_pubsub_topic_iam_binding.testrunner_results_bucket_topic_publish_policy]
}
