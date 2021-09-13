resource "google_pubsub_topic" "ecm_events" {
  name = "ecm-events"

  labels = {
    service : "externalcreds"
  }
}
