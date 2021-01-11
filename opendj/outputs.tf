#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? google_compute_address.ingress_ip[0].address : null
  description = "Ingress IP"
}
output "fqdn" {
  value       = var.enable ? local.fqdn : null
  description = "Fully qualified domain name"
}
