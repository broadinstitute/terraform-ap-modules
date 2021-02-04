# Resources to support backups with mongodump.

# Service account used by Kubernetes CronJob to upload to backup bucket
resource "google_service_account" "backup-sa" {
  provider     = google.target
  account_id   = "mongodb-backup-${local.owner}"
  display_name = "mongodb-backup-${local.owner}"
}

locals {
  seconds_per_day = 24 * 60 * 60 # Used in retention policy
}

# Bucket where mongodb dumps will be stored
resource "google_storage_bucket" "backup-bucket" {
  name          = "mongodb-backups-dsp-terra-${local.owner}"
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
}

# Give backup SA permission to upload objects to bucket
resource "google_storage_bucket_iam_binding" "binding" {
  bucket   = google_storage_bucket.backup-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.backup-sa.email}"]
}
