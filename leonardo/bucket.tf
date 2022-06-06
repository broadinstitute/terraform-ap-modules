# https://broadworkbench.atlassian.net/browse/DDO-2120

resource "google_storage_bucket" "versions_bucket" {
  count                       = var.enable && var.terra_docker_versions_upload_bucket != null ? 1 : 0
  provider                    = google.target
  name                        = var.terra_docker_versions_upload_bucket
  location                    = "NAM4"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "versions_bucket_reader" {
  count    = var.enable && var.terra_docker_versions_upload_bucket != null ? 1 : 0
  provider = google.target
  bucket   = google_storage_bucket.versions_bucket[0].name
  role     = "roles/storage.objectViewer"
  member   = "allUsers"
}

resource "google_storage_bucket_iam_member" "versions_bucket_writer" {
  count    = var.enable && var.terra_docker_versions_upload_bucket != null ? 1 : 0
  provider = google.target
  bucket   = google_storage_bucket.versions_bucket[0].name
  role     = "roles/storage.objectAdmin"
  member   = "serviceAccount:${var.service_accounts["leonardo"]}"
}
