#
# IP/DNS Outputs
#
output "ingress_ips" {
  value       = google_compute_address.ingress.*.address
  description = "Service ingress IPs"
}
output "fqdns" {
  value       = local.fqdns
  description = "Service fully qualified domain names"
}
