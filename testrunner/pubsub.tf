# Pub/Sub topics and subscriptions for Delta Layer

# source topic
resource "google_pubsub_topic" "source" {
  provider = google.target
  project  = var.google_project
  name     = "testrunner-source-topic"
}

# filemover topic
resource "google_pubsub_topic" "filemover" {
  provider = google.target
  project  = var.google_project
  name     = "testrunner-filemover-topic"
}

# N.B. no need to create subscriptions; subscriptions are automatically created when the relevant
# Cloud Functions are deployed.

# permission for TestRunner SA to publish to source topic
resource "google_pubsub_topic_iam_binding" "source-topic-publish" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.source.name
  role     = "roles/pubsub.publisher"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}

# permission for TestRunner SA to publish to filemover topic
resource "google_pubsub_topic_iam_binding" "filemover-topic-publish" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.filemover.name
  role     = "roles/pubsub.publisher"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}

# permission for TestRunner SA to subscribe to source topic
resource "google_pubsub_topic_iam_binding" "source-topic-subscribe" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.source.name
  role     = "roles/pubsub.subscriber"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}

# permission for TestRunner SA to subscribe to filemover topic
resource "google_pubsub_topic_iam_binding" "filemover-topic-subscribe" {
  provider = google.target
  project  = var.google_project
  topic    = google_pubsub_topic.filemover.name
  role     = "roles/pubsub.subscriber"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}
