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

  push_config {
    push_endpoint = "https://${google_compute_address.ingress_ip[0].address}/receive_messages?token=${random_uuid.pubsub-secret-token.result}"

    oidc_token {
      service_account_email = google_service_account.app[0].account_id
    }
  }
}

# import service can publish to its own topic
resource "google_pubsub_topic_iam_member" "crl_janitor_client_can_publish" {
  project = var.google_project
  topic = google_pubsub_topic.crl-janitor-pubsub-topic.name
  role = "roles/pubsub.publisher"
  member   = "serviceAccount:${google_service_account.client[0].email}"
}
