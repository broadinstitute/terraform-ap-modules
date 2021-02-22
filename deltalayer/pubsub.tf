# Pub/Sub topics and subscriptions for Delta Layer

# source topic
resource "google_pubsub_topic" "source" {
  provider = google.target
  project  = var.google_project
  name     = "deltalayer-source-topic"
}

# filemover topic
resource "google_pubsub_topic" "filemover" {
  provider = google.target
  project  = var.google_project
  name     = "deltalayer-filemover-topic"
}

# N.B. no need to create subscriptions; subscriptions are automatically created when the relevant
# Cloud Functions are deployed.

# automatic SA for this project: https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account
data "google_storage_project_service_account" "gcs_account" {
  provider = google.target
  project  = var.google_project
}

# permission for automatic SA to publish to source topic
resource "google_pubsub_topic_iam_binding" "source-topic-publish" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.source.name
  role     = "roles/pubsub.publisher"
  members  = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

# permission for streamer SA to publish to filemover topic
resource "google_pubsub_topic_iam_binding" "filemover-topic-publish" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.filemover.name
  role     = "roles/pubsub.publisher"
  members  = ["serviceAccount:${google_service_account.sa_streamer[0].email}"]
}

# permission for streamer SA to subscribe to source topic
resource "google_pubsub_topic_iam_binding" "source-topic-subscribe" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.source.name
  role     = "roles/pubsub.subscriber"
  members  = ["serviceAccount:${google_service_account.sa_streamer[0].email}"]
}

# permission for filemover SA to subscribe to filemover topic
resource "google_pubsub_topic_iam_binding" "filemover-topic-subscribe" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.filemover.name
  role     = "roles/pubsub.subscriber"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}
