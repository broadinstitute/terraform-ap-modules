# Pub/Sub topics and subscriptions for Test Runner Reporting framework

# source topic
resource "google_pubsub_topic" "source-topic" {
  provider = google.target
  project  = var.google_project
  name     = "source-topic"
}

# Enable notifications by giving the correct IAM permission to the unique service account.

data "google_storage_project_service_account" "gcs_account" {
  provider = google.target
  project = var.google_project
}

resource "google_pubsub_topic_iam_binding" "source-topic-publisher" {
  topic   = google_pubsub_topic.source-topic.id
  role    = "roles/pubsub.publisher"
  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

# End enabling notifications

# streaming error topic
resource "google_pubsub_topic" "streaming_error_topic" {
  provider = google.target
  project  = var.google_project
  name     = "streaming-error-topic"
}

# streaming success topic
resource "google_pubsub_topic" "streaming_success_topic" {
  provider = google.target
  project  = var.google_project
  name     = "streaming-success-topic"
}

# N.B. no need to create subscriptions; subscriptions are automatically created when the relevant
# Cloud Functions are deployed.

# permission for Streamer SA to publish to error topic
resource "google_pubsub_topic_iam_binding" "streaming_error_topic_publisher" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.streaming_error_topic.name
  role     = "roles/pubsub.publisher"
  members  = ["serviceAccount:${google_service_account.sa_bq_streamer[0].email}"]
}

# permission for Streamer SA to publish to success topic
resource "google_pubsub_topic_iam_binding" "streaming_success_topic_publisher" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.streaming_success_topic.name
  role     = "roles/pubsub.publisher"
  members  = ["serviceAccount:${google_service_account.sa_bq_streamer[0].email}"]
}

# permission for filemover SA to subscribe to error topic
resource "google_pubsub_topic_iam_binding" "streaming_error_topic_subscriber" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.streaming_error_topic.name
  role     = "roles/pubsub.subscriber"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}

# permission for filemover SA to subscribe to success topic
resource "google_pubsub_topic_iam_binding" "streaming_success_topic_subscriber" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.streaming_success_topic.name
  role     = "roles/pubsub.subscriber"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}
