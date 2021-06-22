# A predefined GCS bucket containing the zip archive which contains the function
data "google_storage_bucket_object" "function_archive" {
  name   = var.source_archive_object
  bucket = var.source_archive_bucket
}

resource "google_bigquery_dataset" "bq_dataset" {
  provider    = google.target
  dataset_id  = var.bq_dataset
}

resource "google_bigquery_table" "bq_table_schemas" {
  for_each   = var.bq_table_schemas
  provider   = google.target
  dataset_id = google_bigquery_dataset.bq_dataset.dataset_id
  table_id   = each.key
  schema     = each.value
}

resource "google_cloudfunctions_function" "streaming_function" {
  provider              = google.target
  name                  = var.function_name
  description           = var.function_description
  runtime               = "java11"
  available_memory_mb   = var.function_runtime_mb
  entry_point           = var.function_entry_point
  source_archive_bucket = data.google_storage_bucket_object.function_archive.bucket
  source_archive_object = data.google_storage_bucket_object.function_archive.name

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.source-bucket
  }

  environment_variables = {
    GCLOUD_PROJECT = var.google_project
    DATASET        = var.bq_dataset
    TABLE          = var.bq_tables
  }

  service_account_email = google_service_account.sa_streamer.email
}