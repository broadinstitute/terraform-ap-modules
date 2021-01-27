resource "google_compute_resource_policy" "snapshot_schedule" {
  project  = var.google_project
  provider = google.target

  name   = "terra-snapshot-policy"
  region = "us-central1"
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = var.snapshot_start_time
      }
    }
    retention_policy {
      max_retention_days    = var.snapshot_retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      labels = {
        env = var.environment
      }
    }
  }
}
