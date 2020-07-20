#
# IP/DNS Outputs
#
output "ingress_ip" {
  # type        = string
  description = "Prometheus ingress IP"
  value       = var.enable ? google_compute_global_address.ingress_ip[0].address : null
}
output "fqdn" {
  # type        = string
  description = "Prometheus FQDN"
  value       = var.enable ? local.fqdn : null
}
