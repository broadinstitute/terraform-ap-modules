#
# Service Account Outputs
#

output "app_sa_id" {
  value       = var.enable ? google_service_account.app[0].account_id : null
  description = "Identity Concentrator Google service accout ID"
}


#
# CloudSQL PostgreSQL Outputs
#

output "cloudsql_public_ip" {
  value       = var.enable ? module.cloudsql.public_ip : null
  description = "Identity Concentrator CloudSQL instance IP"
}

output "cloudsql_instance_name" {
  value       = var.enable ? module.cloudsql.instance_name : null
  description = "Identity Concentrator CloudSQL instance name"
}

output "cloudsql_root_user_password" {
  value       = var.enable ? module.cloudsql.root_user_password : null
  description = "Identity Concentrator database root password"
  sensitive   = true
}

output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[local.service]) : null
  description = "Identity Concentrator database user credentials"
  sensitive   = true
}
