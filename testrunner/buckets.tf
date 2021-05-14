# Buckets for delta layer

# "Source" bucket: sa_streamer reads, sa_filemover moves.
resource "google_storage_bucket" "source-bucket" {
  name                        = local.files_source
  provider                    = google.target
  project                     = var.google_project
  location                    = var.files_region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "testrunner-sa-binding" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${var.testrunner_sa_email}"]
}

# "Success" bucket: sa_filemover coldline, auto-deletes after 120 days
resource "google_storage_bucket" "success-bucket" {
  name                        = local.files_success
  provider                    = google.target
  project                     = var.google_project
  location                    = var.files_region
  storage_class               = "COLDLINE"
  uniform_bucket_level_access = true

  # Delete after 120 days
  lifecycle_rule {
    condition {
      age = 120
    }
    action {
      type = "Delete"
    }
  }
}

# permission for sa_filemover to move files from
resource "google_storage_bucket_iam_binding" "source-bucket-filemover" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectAdmin"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}

# permission for sa_filemover to move files to coldline
resource "google_storage_bucket_iam_binding" "success-bucket-filemover" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}

# "Error" bucket: sa_filemover creates/writes
resource "google_storage_bucket" "error-bucket" {
  name                        = local.files_error
  provider                    = google.target
  project                     = var.google_project
  location                    = var.files_region
  uniform_bucket_level_access = true
}

# permission for sa_filemover to move files to during error handling
resource "google_storage_bucket_iam_binding" "error-bucket-filemover" {
  bucket   = google_storage_bucket.error-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}

# Pub/Sub notifications for object-finalize in the source bucket
resource "google_storage_notification" "source-finalize-notification" {
  bucket         = google_storage_bucket.source-bucket.name
  payload_format = "JSON_API_V1"
  provider       = google.target
  topic          = google_pubsub_topic.source-topic.id
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [google_pubsub_topic_iam_binding.source-topic-publisher]
}
