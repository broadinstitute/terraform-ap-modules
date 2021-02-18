# Buckets and their IAM policies for Delta Layer


# IAM policy for source bucket: sourcewriter_sa_email creates/writes, sa_filemover reads and deletes, sa_streamer reads
data "google_iam_policy" "iam-source" {
  binding {
    role = "roles/storage.objectCreator"
    members = ["serviceAccount:${var.sourcewriter_sa_email}"]
  }
  binding {
    role = "roles/storage.objectAdmin"
    members = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
  }
  binding {
    role = "roles/storage.objectViewer"
    members = ["serviceAccount:${google_service_account.sa_streamer[0].email}"]
  }
}

# IAM policy for success and error buckets: sa_filemover creates/writes
data "google_iam_policy" "iam-success-error" {
  binding {
    role = "roles/storage.objectCreator"
    members = ["serviceAccount:${google_service_account.sa_filemover[0].email}"]
  }
}


# "Source" bucket
resource "google_storage_bucket" "source-bucket" {
  name     = "terra-deltalayer-source-${local.bucket_suffix}"
  provider = google.target
  project  = var.google_project
  location = var.bucket_location
}

# "Success" bucket: coldline, auto-deletes after 120 days
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

# "Error" bucket
resource "google_storage_bucket" "error-bucket" {
  name     = "terra-deltalayer-error-${local.bucket_suffix}"
  provider = google.target
  project  = var.google_project
  location = var.bucket_location
}

# apply IAM for source bucket
resource "google_storage_bucket_iam_policy" "apply-source-policy" {
  bucket = google_storage_bucket.source-bucket.name
  policy_data = data.google_iam_policy.iam-source.policy_data
  provider = google.target
}

# apply IAM for success bucket
resource "google_storage_bucket_iam_policy" "apply-success-policy" {
  bucket = google_storage_bucket.success-bucket.name
  policy_data = data.google_iam_policy.iam-success-error.policy_data
  provider = google.target
}

# apply IAM for error bucket
resource "google_storage_bucket_iam_policy" "apply-error-policy" {
  bucket = google_storage_bucket.error-bucket.name
  policy_data = data.google_iam_policy.iam-success-error.policy_data
  provider = google.target
}
