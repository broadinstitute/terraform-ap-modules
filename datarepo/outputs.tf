#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? data.google_compute_global_address.ingress_ip[0].address : null
  description = "Datarepo ingress IP"
}
output "grafana_ingress_ip" {
  value       = var.enable ? data.google_compute_global_address.grafana_ingress_ip[0].address : null
  description = "Datarepo grafana ingress IP"
}
output "prometheus_ingress_ip" {
  value       = var.enable ? data.google_compute_global_address.prometheus_ingress_ip[0].address : null
  description = "Datarepo ingress IP"
}
output "datarepo_fqdn" {
  value       = var.enable ? local.datarepo_fqdn : null
  description = "Datarepo fully qualified domain name"
}
output "grafana_fqdn" {
  value       = var.enable ? local.grafana_fqdn : null
  description = "Datarepo grafana fully qualified domain name"
}
output "prometheus_fqdn" {
  value       = var.enable ? local.prometheus_fqdn : null
  description = "Datarepo prometheus fully qualified domain name"
}
