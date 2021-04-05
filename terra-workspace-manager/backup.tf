
# Service account used by Kubernetes CronJob to upload to backup bucket
resource "google_service_account" "backup-sa" {
  provider     = google.target
  account_id   = "wsm-backup-${local.owner}"
  display_name = "wsm-backup-${local.owner}"
}
