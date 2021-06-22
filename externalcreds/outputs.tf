#
# Service Account Outputs
#
output "sqlproxy_sa_id" {
  value       = length(google_service_account.sqlproxy) > 0 ? google_service_account.sqlproxy[0].account_id : null
  description = "External Credentials Manager Cloud SQL Proxy Google service account ID"
}
output "app_sa_id" {
  value       = length(google_service_account.app) > 0 ? google_service_account.app[0].account_id : null
  description = "External Credentials Manager App Google service account ID"
}

#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].address : null
  description = "External Credentials Manager ingress IP"
}
output "ingress_ip_name" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].name : null
  description = "External Credentials Manager ingress IP name"
}
output "fqdn" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? local.fqdn : null
  description = "External Credentials Manager fully qualified domain name"
}

#
# CloudSQL Outputs
#
output "cloudsql_pg13_outputs" {
  description = "External Credentials Manager CloudSQL outputs (pg13 instance)"
  value = {
    # pg13 CloudSQL instance IP
    public_ip = var.enable && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? module.cloudsql-pg13.public_ip : null,
    # pg13 CloudSQL instance name
    instance_name = var.enable && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? module.cloudsql-pg13.instance_name : null
    # pg13 database root password
    root_user_password = var.enable && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? module.cloudsql-pg13.root_user_password : null
    # pg13 app db creds
    app_db_creds = var.enable && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? (length(module.cloudsql-pg13.app_db_creds) == 0 ? {} : module.cloudsql-pg13.app_db_creds[local.service]) : null
  }
  sensitive = true
}
