output "mongodb_backup_sa_id" {
  value       = var.enable ? google_service_account.backup-sa.account_id : null
  description = "MongoDB Backup SA ID"
}
