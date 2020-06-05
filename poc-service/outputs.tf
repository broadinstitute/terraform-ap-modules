#
# Service Account Outputs
#

output "app_sa_id" {
  value = var.enable ? google_service_account.app[0].account_id : null
}


#
# CloudSQL PostgreSQL Outputs
#

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
  value     = var.enable ? (length(module.cloudsql.app_db_creds) == 0 ? {} : module.cloudsql.app_db_creds[local.service]) : null
  sensitive = true
}


#
# IP/DNS Outputs
#
output "ingress_ip" {
  value = var.enable ? google_compute_address.ingress_ip[0].address : null
}
output "fqdn" {
  value = var.enable ? "${local.domain_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}" : null
}
