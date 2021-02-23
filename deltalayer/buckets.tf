# Buckets for delta layer

# "Source" bucket: sourcewriter_sa_email creates/writes, sa_filemover reads and deletes, sa_streamer reads
resource "google_storage_bucket" "source-bucket" {
  name     = "terra-deltalayer-source-${local.bucket_suffix}"
  provider = google.target
  project  = var.google_project
  location = var.bucket_location
}

resource "google_storage_bucket_iam_binding" "success-bucket-sa-binding-sourcewriter" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${var.sourcewriter_sa_email}"]
}

resource "google_storage_bucket_iam_binding" "success-bucket-sa-binding-filemover" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectAdmin"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}

resource "google_storage_bucket_iam_binding" "success-bucket-sa-binding-streamer" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectViewer"
  members  = ["serviceAccount:${google_service_account.sa_streamer[0].email}"]
}

# "Success" bucket: sa_filemover creates/writes, coldline, auto-deletes after 120 days
resource "google_storage_bucket" "success-bucket" {
  name          = "terra-deltalayer-success-${local.bucket_suffix}"
  provider      = google.target
  project       = var.google_project
  location      = var.bucket_location
  storage_class = "COLDLINE"

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

resource "google_storage_bucket_iam_binding" "success-bucket-sa-binding" {
  bucket   = google_storage_bucket.success-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}

# "Error" bucket: sa_filemover creates/writes
resource "google_storage_bucket" "error-bucket" {
  name     = "terra-deltalayer-error-${local.bucket_suffix}"
  provider = google.target
  project  = var.google_project
  location = var.bucket_location
}

resource "google_storage_bucket_iam_binding" "error-bucket-sa-binding" {
  bucket   = google_storage_bucket.error-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
}

# Pub/Sub notifications for object-finalize in the source bucket
resource "google_storage_notification" "source-finalize-notification" {
  bucket         = google_storage_bucket.source-bucket.name
  provider       = google.target
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.source.id
  event_types    = ["OBJECT_FINALIZE"]
  depends_on     = [google_pubsub_topic_iam_binding.source-topic-publish]
}
