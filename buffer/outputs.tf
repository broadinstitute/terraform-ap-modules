#
# Service Account Outputs
#
output "app_sa_id" {
  value       = var.enable ? google_service_account.app[0].account_id : null
  description = "Terra Resource Buffer Service Google service accout ID"
}
output "sqlproxy_sa_id" {
  value       = var.enable ? google_service_account.sqlproxy[0].account_id : null
  description = "Terra Resource Buffer Service Cloud SQL Proxy Google service account ID"
}
output "client_sa_id" {
  value       = var.enable ? google_service_account.client[0].account_id : null
  description = "Client Google service account ID"
}

#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? local.ingress_ip : null
  description = "Terra Resource Buffer Service ingress IP"
}
output "ingress_ip_name" {
  value       = var.enable ? local.ingress_ip_name : null
  description = "Terra Resource Buffer Service ingress IP name"
}
output "fqdn" {
  value       = var.enable ? local.fqdn : null
  description = "Terra Resource Buffer Service fully qualified domain name"
}

#
# CloudSQL PostgreSQL Outputs
#
output "cloudsql_public_ip" {
  value       = var.enable ? module.cloudsql.public_ip : null
  description = "Terra Resource Buffer Service CloudSQL instance IP"
}
output "cloudsql_instance_name" {
  value       = var.enable ? module.cloudsql.instance_name : null
  description = "Terra Resource Buffer Service CloudSQL instance name"
}
output "cloudsql_root_user_password" {
  value       = var.enable ? module.cloudsql.root_user_password : null
  description = "Terra Resource Buffer Service database root password"
  sensitive   = true
}
output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[local.service]) : null
  description = "Terra Resource Buffer Service database user credentials"
  sensitive   = true
}
output "cloudsql_app_stairway_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds["${local.service}-stairway"]) : null
  description = "Terra Resource Buffer Service Stairway database user credentials"
  sensitive   = true
}
