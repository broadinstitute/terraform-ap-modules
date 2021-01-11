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
