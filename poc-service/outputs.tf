#
# Service Account Outputs
#

output "app_sa_id" {
  value       = var.enable ? google_service_account.app[0].account_id : null
  description = "POC app Google service accout ID"
}


#
# CloudSQL PostgreSQL Outputs
#

output "cloudsql_public_ip" {
  value       = var.enable ? module.cloudsql.public_ip : null
  description = "POC app CloudSQL instance IP"
}

output "cloudsql_instance_name" {
  value       = var.enable ? module.cloudsql.instance_name : null
  description = "POC app CloudSQL instance name"
}

output "cloudsql_root_user_password" {
  value       = var.enable ? module.cloudsql.root_user_password : null
  description = "POC app database root password"
  sensitive   = true
}

output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[local.service]) : null
  description = "POC app database user credentials"
  sensitive   = true
}


#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? google_compute_address.ingress_ip[0].address : null
  description = "POC app ingress IP"
}
output "fqdn" {
  value       = var.enable ? local.fqdn : null
  description = "POC app fully qualified domain name"
}
