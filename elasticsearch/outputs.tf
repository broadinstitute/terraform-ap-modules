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
