#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = google_compute_address.ingress_ip.address
  description = "Ingress IP"
}
output "fqdn" {
  value       = local.fqdn
  description = "Fully qualified domain name"
}

#
# Backup Outputs
#
output "backup_sa_id" {
  value       = google_service_account.backup-sa.account_id
  description = "OpenDJ Backup SA ID"
}
