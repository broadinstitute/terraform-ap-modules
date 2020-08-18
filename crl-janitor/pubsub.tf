resource "google_pubsub_topic" "crl-janitor-pubsub-topic" {
  count = var.enable ? 1 : 0

  project = var.google_project
  name = "${local.service}-${local.owner}-pubsub-topic"
}

resource "google_pubsub_topic" "crl-janitor-pubsub-dead-letter-topic" {
  count = var.enable ? 1 : 0

  project = var.google_project
  name = "${local.service}-${local.owner}-pubsub-dead-letter-topic"
}

resource "google_pubsub_subscription" "crl-janitor-pubsub-subscription" {
  count = var.enable ? 1 : 0

  project = var.google_project
  name = "${local.service}-${local.owner}-pubsub-sub"
  topic = google_pubsub_topic.crl-janitor-pubsub-topic[0].name

  ack_deadline_seconds = 20

  expiration_policy {
    // No expiration
    ttl = ""
  }

  dead_letter_policy {
    dead_letter_topic = google_pubsub_topic.crl-janitor-pubsub-dead-letter-topic[0].name
    max_delivery_attempts = 10
  }
}

# Janitor clients can publish to the topic
resource "google_pubsub_topic_iam_member" "crl_janitor_client_can_publish" {
  count = var.enable ? 1 : 0

  project = var.google_project
  topic = google_pubsub_topic.crl-janitor-pubsub-topic[0].name
  role = "roles/pubsub.publisher"
  member   = "serviceAccount:${google_service_account.client[0].email}"
}

# Janitor SA can subscribe and forward the topic
resource "google_pubsub_subscription_iam_member" "crl_janitor_client_can_manage" {
  count = var.enable ? 1 : 0

  subscription = google_pubsub_subscription.crl-janitor-pubsub-subscription[0].name
  role = "roles/editor"
  member   = "serviceAccount:${google_service_account.app[0].email}"
}
