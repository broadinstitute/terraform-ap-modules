#
# Service Account Outputs
#
output "sqlproxy_sa_id" {
  value       = var.enable ? google_service_account.sqlproxy[0].account_id : null
  description = "Workspace Manager Cloud SQL Proxy Google service account ID"
}
output "cloud_trace_sa_id" {
  value       = var.enable ? google_service_account.cloud_trace[0].account_id : null
  description = "Workspace Manager Cloud trace Google service account ID"
}

#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable ? google_compute_address.ingress_ip[0].address : null
  description = "Workspace Manager ingress IP"
}
output "fqdn" {
  value       = var.enable ? local.fqdn : null
  description = "Workspace Manager fully qualified domain name"
}

#
# CloudSQL PostgreSQL Outputs
#
output "cloudsql_public_ip" {
  value       = var.enable ? module.cloudsql.public_ip : null
  description = "Workspace Manager CloudSQL instance IP"
}
output "cloudsql_instance_name" {
  value       = var.enable ? module.cloudsql.instance_name : null
  description = "Workspace Manager CloudSQL instance name"
}
output "cloudsql_root_user_password" {
  value       = var.enable ? module.cloudsql.root_user_password : null
  description = "Workspace Manager database root password"
  sensitive   = true
}
output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[local.service]) : null
  description = "Workspace Manager database user credentials"
  sensitive   = true
}
output "cloudsql_app_stairway_db_creds" {
  value       = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds["${local.service}-stairway"]) : null
  description = "Stairway database user credentials"
  sensitive   = true
}
