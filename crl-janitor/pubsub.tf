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
    dead_letter_topic = google_pubsub_topic.crl-janitor-pubsub-dead-letter-topic[0].id
    max_delivery_attempts = 10
  }
}

resource "google_pubsub_subscription" "crl-janitor-pubsub-dead-letter-subscription" {
  count = var.enable ? 1 : 0

  project = var.google_project
  name = "${local.service}-${local.owner}-dead-letter-pubsub-sub"
  topic = google_pubsub_topic.crl-janitor-pubsub-dead-letter-topic[0].name

  ack_deadline_seconds = 20

  expiration_policy {
    // No expiration
    ttl = ""
  }
}

# Janitor clients can publish to the topic
resource "google_pubsub_topic_iam_member" "crl_janitor_client_can_publish" {
  count = var.enable ? 1 : 0

  project = var.google_project
  topic = google_pubsub_topic.crl-janitor-pubsub-topic[0].name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${google_service_account.client[0].email}"
}

# Janitor SA can subscribe and forward the topic
resource "google_pubsub_subscription_iam_member" "crl_janitor_client_can_manage" {
  count = var.enable ? 1 : 0

  subscription = google_pubsub_subscription.crl-janitor-pubsub-subscription[0].name
  role = "roles/editor"
  member = "serviceAccount:${google_service_account.app[0].email}"
}

# Project SA can publish to the dead letter queue topic
resource "google_pubsub_topic_iam_member" "crl_janitor_client_can_publish_dead_letter" {
  count = var.enable ? 1 : 0

  project = var.google_project
  topic = google_pubsub_topic.crl-janitor-pubsub-dead-letter-topic[0].name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${data.google_service_account.project_pubsub_sa.email}"
}

# Project SA can subscribe to the dead letter queue topic
resource "google_pubsub_subscription_iam_member" "crl_janitor_client_can_subscribe_dead_letter" {
  count = var.enable ? 1 : 0
  project = var.google_project
  subscription = google_pubsub_subscription.crl-janitor-pubsub-dead-letter-subscription[0].name
  role = "roles/pubsub.subscriber"
  member = "serviceAccount:${data.google_service_account.project_pubsub_sa.email}"
}
