output "cloudsql_public_ip" {
  value = var.enable ? module.cloudsql.public_ip : null
}

output "cloudsql_instance_name" {
  value = var.enable ? module.cloudsql.instance_name : null
}

output "cloudsql_root_user_password" {
  value     = var.enable ? module.cloudsql.root_user_password : null
  sensitive = true
}

output "cloudsql_app_db_creds" {
  # Avoiding error on destroy with below condition
  value     = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds["sam"]) : null
  sensitive = true
}
