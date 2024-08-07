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
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable && var.dns_enabled && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].address : null
  description = "Workspace Manager ingress IP"
}
output "ingress_ip_name" {
  value       = var.enable && var.dns_enabled && contains(["default", "preview"], var.env_type) ? google_compute_global_address.ingress_ip[0].name : null
  description = "Sam ingress IP name"
}
output "fqdn" {
  value       = var.enable && var.dns_enabled && contains(["default", "preview"], var.env_type) ? local.fqdn : null
  description = "Workspace Manager fully qualified domain name"
}

#
# CloudSQL Outputs
#
output "cloudsql_pg13_outputs" {
  description = "Workspace Manager CloudSQL outputs (pg13 instance)"
  value = {
    # pg13 CloudSQL instance IP
    public_ip = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? module.cloudsql-pg13.public_ip : null,
    # pg13 CloudSQL instance name
    instance_name = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? module.cloudsql-pg13.instance_name : null
    # pg13 database root password
    root_user_password = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? module.cloudsql-pg13.root_user_password : null
    # pg13 app db creds
    app_db_creds = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? (length(module.cloudsql-pg13.app_db_creds) == 0 ? {} : module.cloudsql-pg13.app_db_creds[local.service]) : null
    # pg13 stairway db creds
    stairway_db_creds = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? (length(module.cloudsql-pg13.app_db_creds) == 0 ? {} : module.cloudsql-pg13.app_db_creds["${local.service}-stairway"]) : null
    # pg13 policy db creds
    policy_db_creds = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? (length(module.cloudsql-pg13.app_db_creds) == 0 ? {} : module.cloudsql-pg13.app_db_creds["${local.service}-policy"]) : null
    # pg13 landingzone db creds
    landingzone_db_creds = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? (length(module.cloudsql-pg13.app_db_creds) == 0 ? {} : module.cloudsql-pg13.app_db_creds["${local.service}-landingzone"]) : null
    # pg13 landingzone stairway db creds
    landingzone_stairway_db_creds = var.enable && var.cloudsql_enabled && contains(["default"], var.env_type) && local.cloudsql_pg13_settings.enable ? (length(module.cloudsql-pg13.app_db_creds) == 0 ? {} : module.cloudsql-pg13.app_db_creds["${local.service}-landingzone-stairway"]) : null
  }
  sensitive = true
}
