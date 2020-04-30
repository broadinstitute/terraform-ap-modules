output "ci_sa_id" {
  value = google_service_account.ci.account_id
}

# IPs for outgoing traffic from the cluster
output "egress_ips" {
  value = google_compute_address.nat-address.*.address
}
