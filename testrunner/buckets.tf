# Buckets for delta layer

# "Source" bucket: testrunner_sa creates/writes, reads and deletes, sa_streamer reads
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

# "Success" bucket: testrunner_sa creates/writes, coldline, auto-deletes after 120 days
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

resource "google_storage_bucket_iam_binding" "success-bucket-sa-binding-streamer" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectViewer"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}

resource "google_storage_bucket_iam_binding" "success-bucket-sa-binding-filemover" {
  bucket   = google_storage_bucket.source-bucket.name
  provider = google.target
  role     = "roles/storage.objectAdmin"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}

resource "google_storage_bucket_iam_binding" "success-bucket-sa-binding" {
  bucket   = google_storage_bucket.success-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}

# "Error" bucket: sa_filemover creates/writes
resource "google_storage_bucket" "error-bucket" {
  name                        = local.files_error
  provider                    = google.target
  project                     = var.google_project
  location                    = var.files_region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "error-bucket-sa-binding-filemover" {
  bucket   = google_storage_bucket.error-bucket.name
  provider = google.target
  role     = "roles/storage.objectAdmin"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
}

resource "google_storage_bucket_iam_binding" "error-bucket-sa-binding" {
  bucket   = google_storage_bucket.error-bucket.name
  provider = google.target
  role     = "roles/storage.objectCreator"
  members  = ["serviceAccount:${google_service_account.sa_testrunner[0].email}"]
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
