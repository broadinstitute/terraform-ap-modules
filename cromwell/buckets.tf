#
# cromwell-configs-prod
#
locals {
  app_sa_name = "cromwell-${local.owner}"
}

# TODO Existing Google service account is still managed by terraform-firecloud
data "google_service_account" "app-sa" {
  account_id = local.app_sa_name
}

# Bucket where mongodb dumps will be stored
resource "google_storage_bucket" "configs-bucket" {
  name     = "cromwell-configs-${local.owner}"
  provider = google.target

  project       = var.google_project
  location      = "us-central1"
  storage_class = "STANDARD"
}

# Give Cromwell app SA permission to write to bucket
resource "google_storage_bucket_iam_binding" "binding" {
  provider = google.target

  bucket  = google_storage_bucket.configs-bucket.name
  role    = ["roles/storage.objectAdmin"]
  members = [data.google_service_account.app-sa.name]
}
