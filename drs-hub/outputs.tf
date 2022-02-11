#
# Service Account Outputs
#
output "app_sa_id" {
  value       = length(google_service_account.app) > 0 ? google_service_account.app[0].account_id : null
  description = "DRS Hub App Google service account ID"
}

#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].address : null
  description = "DRS Hub ingress IP"
}
output "ingress_ip_name" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].name : null
  description = "DRS Hub ingress IP name"
}
output "fqdn" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? local.fqdn : null
  description = "DRS Hub fully qualified domain name"
}
