resource "google_cloudfunctions_function" "bq-streamer" {
  name        = "bq-streamer"
  description = "Cloud function for streaming JSON from source-bucket to BigQuery"
  runtime     = "java11"

  available_memory_mb   = 512

  timeout               = 60

  # This class entry point does not exist yet.
  entry_point           = "functions.streaming.bq"

  event_trigger {
    resource = google_storage_bucket.source-bucket
    event_type = "google.storage.object.finalize"
  }

  # The SA associated with the function at runtime.
  service_account_email = google_service_account.sa_bq_streamer[0].email

  # A set of key-value environment pairs to assign to the function.
  # These can be used to set up custom vars to configure the cloud function
  # for different target environments.
  environment_variables = {
    BQ_DATASET_ID = "${var.google_project}.${var.bq_dataset_id}"
  }

  source_repository = {
    url = "https://source.developers.google.com/projects/${var.google_project}/repos/${var.cloud_functions_repo}/master/paths/src/functions/streaming"
  }

  # Only us-central1 is supported at this time.
  region = "us-central1"
}

# grant streamer SA ownership to BigQuery dataset
resource "google_bigquery_dataset_iam_binding" "bq-streamer-rb" {
  provider       = google.target
  project        = var.google_project
  dataset_id     = var.bq_dataset_id
  role           = "roles/bigquery.dataOwner"
  members        = ["serviceAccount:${google_service_account.sa_bq_streamer[0].email}"]
}

resource "google_cloudfunctions_function" "streaming-error-handler" {
  name        = "streaming-error-handler"
  description = "Cloud function for handling streaming errors"
  runtime     = "java11"

  available_memory_mb   = 512

  timeout               = 60

  # This class entry point does not exist yet.
  entry_point           = "functions.fileMover"

  event_trigger {
    resource = google_pubsub_topic.streaming_error_topic
    event_type = "google.pubsub.topic.publish"
  }

  # The SA associated with the function at runtime.
  service_account_email = google_service_account.sa_filemover[0].email

  # A set of key-value environment pairs to assign to the function.
  # These can be used to set up custom vars to configure the cloud function
  # for different target environments.
  environment_variables = {
    DESTINATION_BUCKET = var.files_error
  }

  source_repository = {
    url = "https://source.developers.google.com/projects/${var.google_project}/repos/${var.cloud_functions_repo}/master/paths/src/functions"
  }

  # Only us-central1 is supported at this time.
  region = "us-central1"
}

resource "google_cloudfunctions_function" "streaming-success-handler" {
  name        = "streaming-success-handler"
  description = "Cloud function for handling streaming success"
  runtime     = "java11"

  available_memory_mb   = 512

  timeout               = 60

  # This class entry point does not exist yet.
  entry_point           = "functions.fileMover"

  event_trigger {
    resource = google_pubsub_topic.streaming_success_topic
    event_type = "google.pubsub.topic.publish"
  }

  # The SA associated with the function at runtime.
  service_account_email = google_service_account.sa_filemover[0].email

  # A set of key-value environment pairs to assign to the function.
  # These can be used to set up custom vars to configure the cloud function
  # for different target environments.
  environment_variables = {
    DESTINATION_BUCKET = var.files_success
  }

  source_repository = {
    url = "https://source.developers.google.com/projects/${var.google_project}/repos/${var.cloud_functions_repo}/master/paths/src/functions"
  }

  # Only us-central1 is supported at this time.
  region = "us-central1"
}
