#
# Service Account Outputs
#

output "app_sa_id" {
  value = google_service_account.app.account_id
}


#
# CloudSQL PostgreSQL Outputs
#

output "cloudsql_public_ip" {
  value = module.cloudsql.public_ip
}

output "cloudsql_instance_name" {
  value = module.cloudsql.instance_name
}

output "cloudsql_root_user_password" {
  value = module.cloudsql.root_user_password
  sensitive = true
}

output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value = length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[var.service]
  sensitive = true
}
