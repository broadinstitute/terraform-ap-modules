#
# Service Account Outputs
#
output "app_sa_id" {
  value       = var.enable ? google_service_account.app[0].account_id : null
  description = "CRL Janitor Google service accout ID"
}

#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? google_compute_address.ingress_ip[0].address : null
  description = "CRL Janitor ingress IP"
}
output "fqdn" {
  value       = var.enable ? local.fqdn : null
  description = "CRL Janitor fully qualified domain name"
}

#
# CloudSQL PostgreSQL Outputs
#
output "cloudsql_public_ip" {
  value       = var.enable ? module.cloudsql.public_ip : null
  description = "CRL Janitor CloudSQL instance IP"
}
output "cloudsql_instance_name" {
  value       = var.enable ? module.cloudsql.instance_name : null
  description = "CRL Janitor CloudSQL instance name"
}
output "cloudsql_root_user_password" {
  value       = var.enable ? module.cloudsql.root_user_password : null
  description = "CRL Janitor database root password"
  sensitive   = true
}
output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[local.service]) : null
  description = "CRL Janitor database user credentials"
  sensitive   = true
}
