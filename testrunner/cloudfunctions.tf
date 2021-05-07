resource "google_cloudfunctions_function" "bq" {
  name        = "testrunner-bq-streamer"
  description = "Cloud function for streaming test runner results from source-bucket to BigQuery"
  runtime     = "java11"

  available_memory_mb   = 128
  source_repository = {
    url = "https://source.developers.google.com/projects/${var.google_project}/repos/${var.cloud_functions_repo}/master/paths/src/functions/streaming"
  }

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource = google_storage_bucket.source-bucket
  }
  timeout               = 60
  # The class entry point does not exist yet.
  entry_point           = "functions.streaming.bq"

  # A set of key-value environment pairs to assign to the function.
  # These can be used to set up custom vars to configure the cloud function
  # for different target environments.
  environment_variables = {
    BQ_DATASET = "`${var.google_project}.${var.bq_dataset}`"
  }

  # Only us-central1 is supported at this time.
  region = "us-central1"
}

# IAM entry for Test Runner SA to invoke the function
resource "google_cloudfunctions_function_iam_member" "bq-invoker" {
  project        = google_cloudfunctions_function.bq.project
  region         = google_cloudfunctions_function.bq.region
  cloud_function = google_cloudfunctions_function.bq.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${var.testrunner_sa_email}"
}
