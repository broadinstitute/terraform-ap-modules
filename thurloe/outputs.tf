#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? google_compute_global_address.ingress_ip[0].address : null
  description = "Thurloe ingress IP"
}
output "fqdn" {
  value       = var.enable ? local.fqdn : null
  description = "Thurloe fully qualified domain name"
}
