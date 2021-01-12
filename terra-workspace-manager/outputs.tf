#
# Service Account Outputs
#
output "sqlproxy_sa_id" {
  value       = length(google_service_account.sqlproxy) > 0 ? google_service_account.sqlproxy[0].account_id : null
  description = "Workspace Manager Cloud SQL Proxy Google service account ID"
}
output "app_sa_id" {
  value       = length(google_service_account.app) > 0 ? google_service_account.app[0].account_id : null
  description = "Workspace Manager App Google service account ID"
}

#
# Infrastructure Outputs
#
output "workspace_container_folder_id" {
  value       =  length(google_folder.workspace_project_folder) > 0 ? google_folder.workspace_project_folder[0].id : null
  description = "The folder id of the folder that workspace projects should be created within."
}

#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].address : null
  description = "Workspace Manager ingress IP"
}
output "ingress_ip_name" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].name : null
  description = "Sam ingress IP name"
}
output "fqdn" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? local.fqdn : null
  description = "Workspace Manager fully qualified domain name"
}

#
# CloudSQL PostgreSQL Outputs
#
output "cloudsql_public_ip" {
  value       = var.enable && contains(["default"], var.env_type) ? module.cloudsql.public_ip : null
  description = "Workspace Manager CloudSQL instance IP"
}
output "cloudsql_instance_name" {
  value       = var.enable && contains(["default"], var.env_type) ? module.cloudsql.instance_name : null
  description = "Workspace Manager CloudSQL instance name"
}
output "cloudsql_root_user_password" {
  value       = var.enable && contains(["default"], var.env_type) ? module.cloudsql.root_user_password : null
  description = "Workspace Manager database root password"
  sensitive   = true
}
output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable && contains(["default"], var.env_type) ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[local.service]) : null
  description = "Workspace Manager database user credentials"
  sensitive   = true
}
output "cloudsql_app_stairway_db_creds" {
  value       = var.enable && contains(["default"], var.env_type) ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds["${local.service}-stairway"]) : null
  description = "Stairway database user credentials"
  sensitive   = true
}
