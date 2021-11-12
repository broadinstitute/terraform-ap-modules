#
# IP/DNS Outputs
#
output "ingress_ip" {
  description = "Prometheus ingress IP"
  value       = var.enable ? google_compute_global_address.ingress_ip[0].address : null
}
output "fqdn" {
  description = "Prometheus FQDN"
  value       = var.enable ? local.fqdn : null
}

output "thanos_ip" {
  description = "ip address to access thanos sidecar"
  value       = var.enable_thanos ? google_compute_address.thanos_sidecar_ip[0].address : null
}

output "thanos_fqdn" {
  description = "FQDN to access thanos sidecar"
  value       = var.enable_thanos ? local.fqdn : null
}
