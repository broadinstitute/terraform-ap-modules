#
# Service account ID Outputs
#

output "sa_streamer_id" {
  value       = google_service_account.sa_streamer[0].account_id
  description = "Streamer SA ID"
}

output "sa_filemover_id" {
  value       = google_service_account.sa_filemover[0].account_id
  description = "File-mover SA ID"
}

output "sa_deployer_id" {
  value       = google_service_account.sa_deployer[0].account_id
  description = "Deployer SA ID"
}

#
# CloudSQL PostgreSQL Outputs
#
output "cloudsql_public_ip" {
  value       = var.enable ? module.cloudsql[0].public_ip : null
  description = "Delta Layer CloudSQL instance IP"
}
output "cloudsql_instance_name" {
  value       = var.enable ? module.cloudsql[0].instance_name : null
  description = "Delta Layer CloudSQL instance name"
}
output "cloudsql_root_user_password" {
  value       = var.enable ? module.cloudsql[0].root_user_password : null
  description = "Delta Layer database root password"
  sensitive   = true
}
output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value       = var.enable ? (length(module.cloudsql[0].app_db_creds) == 0 ? {} : module.cloudsql[0].app_db_creds[local.service]) : null
  description = "Delta Layer database user credentials"
  sensitive   = true
}
