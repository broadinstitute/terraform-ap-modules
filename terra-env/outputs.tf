#
# POC Service Outputs
#
output "poc_sa_id" {
  value       = module.poc_service.app_sa_id
  description = "POC app Google service accout ID"
}
output "poc_db_ip" {
  value       = module.poc_service.cloudsql_public_ip
  description = "POC app CloudSQL instance IP"
}
output "poc_db_instance" {
  value       = module.poc_service.cloudsql_instance_name
  description = "POC app CloudSQL instance name"
}
output "poc_db_root_pass" {
  value       = module.poc_service.cloudsql_root_user_password
  description = "POC app database root password"
  sensitive   = true
}
output "poc_db_creds" {
  value       = module.poc_service.cloudsql_app_db_creds
  description = "POC app database user credentials"
  sensitive   = true
}
output "poc_ingress_ip" {
  value       = module.poc_service.ingress_ip
  description = "POC app ingress IP"
}
output "poc_fqdn" {
  value       = module.poc_service.fqdn
  description = "POC app fully qualified domain name"
}

#
# Identity Concentrator Outputs
#
output "ic_sa_id" {
  value       = module.identity_concentrator.app_sa_id
  description = "Identity Concentrator Google service accout ID"
}
output "ic_db_ip" {
  value       = module.identity_concentrator.cloudsql_public_ip
  description = "Identity Concentrator CloudSQL instance IP"
}
output "ic_db_instance" {
  value       = module.identity_concentrator.cloudsql_instance_name
  description = "Identity Concentrator CloudSQL instance name"
}
output "ic_db_root_pass" {
  value       = module.identity_concentrator.cloudsql_root_user_password
  description = "Identity Concentrator database root password"
  sensitive   = true
}
output "ic_db_creds" {
  value       = module.identity_concentrator.cloudsql_app_db_creds
  description = "Identity Concentrator database user credentials"
  sensitive   = true
}

#
# Sam Outputs
#
output "sam_sa_email" {
  value       = module.sam.service_account_email
  description = "SAM Google service account email"
}
output "sam_admin_sdk_sa_emails" {
  value       = module.sam.admin_sdk_service_account_emails
  description = "SAM admin SDK Google service account emails"
}

#
# Sam Persistence Outputs
#
output "sam_db_ip" {
  value       = module.sam_persistence.cloudsql_public_ip
  description = "SAM CloudSQL instance IP"
}
output "sam_db_instance" {
  value       = module.sam_persistence.cloudsql_instance_name
  description = "SAM CloudSQL instance name"
}
output "sam_db_root_password" {
  value       = module.sam_persistence.cloudsql_root_user_password
  description = "SAM database root password"
  sensitive   = true
}
output "sam_db_creds" {
  value       = module.sam_persistence.cloudsql_app_db_creds
  description = "SAM database user credentials"
  sensitive   = true
}

#
# Workspace Manager Outputs
#
output "workspace_sa_id" {
  value       = module.workspace_manager.app_sa_id
  description = "Workspace Manager Google service accout ID"
}
output "workspace_db_ip" {
  value       = module.workspace_manager.cloudsql_public_ip
  description = "Workspace Manager CloudSQL instance IP"
}
output "workspace_db_instance" {
  value       = module.workspace_manager.cloudsql_instance_name
  description = "Workspace Manager CloudSQL instance name"
}
output "workspace_db_root_pass" {
  value       = module.workspace_manager.cloudsql_root_user_password
  description = "Workspace Manager database root password"
  sensitive   = true
}
output "workspace_db_creds" {
  value       = module.workspace_manager.cloudsql_app_db_creds
  description = "Workspace Manager database user credentials"
  sensitive   = true
}
output "workspace_stairway_db_creds" {
  value       = module.workspace_manager.cloudsql_app_stairway_db_creds
  description = "Stairway database user credentials"
  sensitive   = true
}
output "workspace_ingress_ip" {
  value       = module.workspace_manager.ingress_ip
  description = "Workspace Manager ingress IP"
}
output "workspace_fqdn" {
  value       = module.workspace_manager.fqdn
  description = "Workspace Manager fully qualified domain name"
}

#
# CRL Janitor Service Outputs
#
output "crl_janitor_sa_id" {
  value       = module.crl_janitor.app_sa_id
  description = "CRL Janitor Google service accout ID"
}
output "crl_janitor_db_ip" {
  value       = module.crl_janitor.cloudsql_public_ip
  description = "CRL Janitor CloudSQL instance IP"
}
output "crl_janitor_db_instance" {
  value       = module.crl_janitor.cloudsql_instance_name
  description = "CRL Janitor CloudSQL instance name"
}
output "crl_janitor_db_root_pass" {
  value       = module.crl_janitor.cloudsql_root_user_password
  description = "CRL Janitor database root password"
  sensitive   = true
}
output "crl_janitor_db_creds" {
  value       = module.crl_janitor.cloudsql_app_db_creds
  description = "CRL Janitor database user credentials"
  sensitive   = true
}
output "crl_janitor_stairway_db_creds" {
  value       = module.crl_janitor.cloudsql_app_stairway_db_creds
  description = "CRL Janitor Stairway database user credentials"
  sensitive   = true
}
output "crl_janitor_ingress_ip" {
  value       = module.crl_janitor.ingress_ip
  description = "CRL Janitor ingress IP"
}
output "crl_janitor_fqdn" {
  value       = module.crl_janitor.fqdn
  description = "CRL Janitor fully qualified domain name"
}