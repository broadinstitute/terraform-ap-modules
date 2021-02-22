output "diskmanager_sa_id" {
  value       = google_service_account.diskmanager_sa.account_id
  description = "Disk Manager service account id"
}
