#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? data.google_compute_global_address.ingress_ip[0].address : null
  description = "Datarepo ingress IP"
}
output "fqdn" {
  value       = var.enable ? local.fqdn : null
  description = "Datarepo fully qualified domain name"
}
