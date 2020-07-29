resource "google_pubsub_topic" "crl-janitor-pubsub-topic" {
  project = var.google_project
  name = "${local.owner}-${local.service}-pubsub-topic"
}

resource "random_uuid" "pubsub-secret-token" {}

resource "google_pubsub_subscription" "crl-janitor-pubsub-subscription" {
  project = var.google_project
  name = "${local.owner}-${local.service}-pubsub-sub"
  topic = google_pubsub_topic.crl-janitor-pubsub-topic.name

  ack_deadline_seconds = 600

  expiration_policy {
    ttl = ""
  }
}

# CRL Client can publish to the topic
resource "google_pubsub_topic_iam_member" "crl_janitor_client_can_publish" {
  project = var.google_project
  topic = google_pubsub_topic.crl-janitor-pubsub-topic.name
  role = "roles/pubsub.publisher"
  member   = "serviceAccount:${google_service_account.client[0].email}"
}

# Janitor SA can subscribe to the topic
resource "google_pubsub_subscription_iam_member" "crl_janitor_client_can_publish" {
  subscription = google_pubsub_subscription.crl-janitor-pubsub-subscription.name
  role = "roles/editor"
  member   = "serviceAccount:${google_service_account.client[0].email}"
}