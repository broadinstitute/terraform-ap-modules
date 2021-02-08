#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = google_compute_address.ingress_ip.address
  description = "elasticsearch ingress IP"
}
output "fqdn" {
  value       = local.fqdn
  description = "elasticsearch fully qualified domain name"
}

output "snapshot_sa_id" {
  value       = google_service_account.elasticsearch-snapshot.account_id
  description = "Elasticsearch Snapshot SA ID"
}
