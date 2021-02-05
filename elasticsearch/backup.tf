# Resources to enable saving Elastic search snapshots in a gcs bucket for backup restore

resource "google_service_account" "elasticsearch-snapshot" {
  provider     = google.target
  account_id   = "elasticsearch-snapshot-${local.owner}"
  display_name = "elasticsearch-snapshot-${local.owner}"
}

locals {
  seconds_per_day = 24 * 60 * 60
}

resource "google_storage_bucket" "es-snapshot-bucket" {
  name          = "elasticsearch-backups-dsp-terra-${local.owner}"
  provider      = google.target
  location      = "US"
  storage_class = "NEARLINE"

  # Retain for 30 days
  retention_policy {
    retention_period = 30 * local.seconds_per_day
  }

  # Delete after 1 year
  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type = "Delete"
    }
  }
}

# Grant sa permission to write to bucket
resource "google_storage_bucket_iam_binding" "es-sa-binding" {
  bucket   = google_storage_bucket.es-snapshot-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.elasticsearch-snapshot.email}"]
}
