output "ci_sa_id" {
  value       = google_service_account.ci.account_id
  description = "Google service account ID used for CI"
}

output "egress_ips" {
  value       = google_compute_address.nat-address.*.address
  description = "IPs for outgoing traffic from the cluster"
}
