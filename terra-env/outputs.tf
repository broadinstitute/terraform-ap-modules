#
# POC Service Outputs
#
output "poc_sa_id" {
  value = module.poc_service.app_sa_id
}
output "poc_db_ip" {
  value = module.poc_service.cloudsql_public_ip
}
output "poc_db_instance" {
  value = module.poc_service.cloudsql_instance_name
}
output "poc_db_root_pass" {
  value     = module.poc_service.cloudsql_root_user_password
  sensitive = true
}
output "poc_db_creds" {
  value     = module.poc_service.cloudsql_app_db_creds
  sensitive = true
}
output "poc_ingress_ip" {
  value = module.poc_service.ingress_ip
}
output "poc_fqdn" {
  value = module.poc_service.fqdn
}

#
# Identity Concentrator Outputs
#
output "ic_sa_id" {
  value = module.identity_concentrator.app_sa_id
}

output "ic_db_ip" {
  value = module.identity_concentrator.cloudsql_public_ip
}
output "ic_db_instance" {
  value = module.identity_concentrator.cloudsql_instance_name
}
output "ic_db_root_pass" {
  value     = module.identity_concentrator.cloudsql_root_user_password
  sensitive = true
}
output "ic_db_creds" {
  value     = module.identity_concentrator.cloudsql_app_db_creds
  sensitive = true
}

#
# Sam Outputs
#
output "sam_sa_email" {
  value = module.sam.service_account_email
}
output "sam_admin_sdk_sa_emails" {
  value = module.sam.admin_sdk_service_account_emails
}

#
# Sam Persistence Outputs
#

output "sam_db_ip" {
  value = module.sam_persistence.cloudsql_public_ip
}

output "sam_db_instance" {
  value = module.sam_persistence.cloudsql_instance_name
}

output "sam_db_root_password" {
  value = module.sam_persistence.cloudsql_root_user_password
  sensitive = true
}

output "sam_db_creds" {
  value = module.sam_persistence.cloudsql_app_db_creds
  sensitive = true
}

#
# Workspace Manager Outputs
#
output "workspace_sa_id" {
  value = module.workspace_manager.app_sa_id
}
output "workspace_db_ip" {
  value = module.workspace_manager.cloudsql_public_ip
}
output "workspace_db_instance" {
  value = module.workspace_manager.cloudsql_instance_name
}
output "workspace_db_root_pass" {
  value = module.workspace_manager.cloudsql_root_user_password
  sensitive = true
}
output "workspace_db_creds" {
  value = module.workspace_manager.cloudsql_app_db_creds
  sensitive = true
}
output "workspace_stairway_db_creds" {
  value = module.workspace_manager.cloudsql_app_stairway_db_creds
  sensitive = true
}
output "workspace_ingress_ip" {
  value = module.workspace_manager.ingress_ip
}
output "workspace_fqdn" {
  value = module.workspace_manager.fqdn
}

#
# CRL Janitor Service Outputs
#
output "crl_janitor_sa_id" {
  value = module.crl_janitor.app_sa_id
}
output "crl_janitor_db_ip" {
  value = module.crl_janitor.cloudsql_public_ip
}
output "crl_janitor_db_instance" {
  value = module.crl_janitor.cloudsql_instance_name
}
output "crl_janitor_db_root_pass" {
  value     = module.crl_janitor.cloudsql_root_user_password
  sensitive = true
}
output "crl_janitor_db_creds" {
  value     = module.crl_janitor.cloudsql_app_db_creds
  sensitive = true
}
output "crl_janitor_ingress_ip" {
  value = module.crl_janitor.ingress_ip
}
output "crl_janitor_fqdn" {
  value = module.crl_janitor.fqdn
}