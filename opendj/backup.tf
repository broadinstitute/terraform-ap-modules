# Resources to support OpenDJ backups.

# Service account used by Kubernetes CronJob to upload to backup bucket
resource "google_service_account" "backup-sa" {
  provider     = google.target
  account_id   = "opendj-backup-${local.owner}"
  display_name = "opendj-backup-${local.owner}"
}

locals {
  seconds_per_day = 24 * 60 * 60 # Used in retention policy
}

# Bucket where opendj dumps will be stored
resource "google_storage_bucket" "backup-bucket" {
  name          = "opendj-backups-dsp-terra-${local.owner}"
  provider      = google.target
  location      = "US"
  storage_class = "NEARLINE" # Retrieval will be rare, but retention might be adjusted

  # Retain objects for minimum of 30 days
  retention_policy {
    retention_period = 30 * local.seconds_per_day
  }

  # Auto-delete objects after a year
  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type = "Delete"
    }
  }

  # Enable Uniform Bucket-Level Access
  # https://docs.bridgecrew.io/docs/bc_gcp_gcs_2
  uniform_bucket_level_access = true
}

# Give backup SA permission to upload objects to bucket
resource "google_storage_bucket_iam_binding" "binding" {
  bucket   = google_storage_bucket.backup-bucket.name
  provider = google.target
  role     = "roles/storage.objectAdmin"
  members  = ["serviceAccount:${google_service_account.backup-sa.email}"]
}
