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
  value = module.cloudsql.app_db_creds
  sensitive = true
}
