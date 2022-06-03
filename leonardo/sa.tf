# See DDO-2120 for more information on why this is necessary
resource "google_storage_bucket_iam_member" "member" {
  count  = var.enable && contains(keys(var.service_accounts), "leonardo") && length(var.service_accounts["leonardo"]) > 0 ? 1 : 0
  bucket = var.terra_docker_versions_upload_bucket
  role   = "roles/storage.objectAdmin"
  member = var.service_accounts["leonardo"]
}
