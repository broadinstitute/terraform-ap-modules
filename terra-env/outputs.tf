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
output "sam_app_sa_id" {
  value       = module.sam.app_sa_id
  description = "SAM Google service account ID"
}
output "sam_admin_sdk_sa_ids" {
  value       = module.sam.admin_sdk_sa_ids
  description = "SAM admin SDK Google service account IDs"
}
output "sam_firestore_sa_id" {
  value       = module.sam.firestore_sa_id
  description = "Sam Firestore Google service account ID"
}
output "sam_firestore_project_name" {
  value       = module.sam.firestore_project_name
  description = "Sam Firestore project name"
}
output "sam_ingress_ip" {
  value       = module.sam.ingress_ip
  description = "Workspace Manager ingress IP"
}
output "sam_fqdn" {
  value       = module.sam.fqdn
  description = "Workspace Manager fully qualified domain name"
}

#
# Workspace Manager Outputs
#
output "workspace_sqlproxy_sa_id" {
  value       = module.workspace_manager.sqlproxy_sa_id
  description = "Workspace Manager Cloud SQL Proxy Google service account ID"
}
output "workspace_cloud_trace_sa_id" {
  value       = module.workspace_manager.cloud_trace_sa_id
  description = "Workspace Manager Cloud trace Google service account ID"
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
  description = "CRL Janitor Google service account ID"
}
output "crl_janitor_sqlproxy_sa_id" {
  value       = module.crl_janitor.sqlproxy_sa_id
  description = "CRL Janitor Cloud SQL Proxy Google service account ID"
}
output "crl_janitor_client_sa_id" {
  value       = module.crl_janitor.client_sa_id
  description = "CRL Janitor Google service account ID"
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
output "crl_janitor_pubsub_topic" {
  value       = module.crl_janitor.pubsub_topic
  description = "CRL Janitor Pub/sub Topic"
}
output "crl_janitor_pubsub_subscription" {
  value       = module.crl_janitor.pubsub_subscription
  description = "CRL Janitor Pub/sub Subscription name"
}

#
# Ontology Outputs
#
output "ontology_ip" {
  value       = module.ontology.ingress_ip
  description = "Ontology service static ip"
}
output "ontology_fqdn" {
  value       = module.ontology.fqdn
  description = "Fqdn for the ontology service"
}

#
# Preview Environment Outputs
#
output "versions" {
  value       = contains(["preview"], var.env_type) ? var.versions : null
  description = "Base64 encoded JSON string of version overrides"
}
output "ingress_ips" {
  value       = contains(["preview"], var.env_type) ? {
    workspacemanager = local.terra_apps["workspace_manager"] ? module.workspace_manager.ingress_ip : null
  } : null
  description = "Service ingress IPs"
}
output "fqdns" {
  value       = contains(["preview"], var.env_type) ? {
    workspacemanager = local.terra_apps["workspace_manager"] ? module.workspace_manager.fqdn : null
  } : null
  description = "Service fully qualified domain names"
}

#
# Terra Resource Buffering Service Outputs
#
output "rbs_sa_id" {
  value       = module.rbs.app_sa_id
  description = "Terra RBS Google service account ID"
}
output "rbs_sqlproxy_sa_id" {
  value       = module.rbs.sqlproxy_sa_id
  description = "Terra RBS Cloud SQL Proxy Google service account ID"
}
output "rbs_db_ip" {
  value       = module.rbs.cloudsql_public_ip
  description = "Terra RBS CloudSQL instance IP"
}
output "rbs_db_instance" {
  value       = module.rbs.cloudsql_instance_name
  description = "Terra RBS CloudSQL instance name"
}
output "rbs_db_root_pass" {
  value       = module.rbs.cloudsql_root_user_password
  description = "Terra RBS database root password"
  sensitive   = true
}
output "rbs_db_creds" {
  value       = module.rbs.cloudsql_app_db_creds
  description = "Terra RBS database user credentials"
  sensitive   = true
}
output "rbs_stairway_db_creds" {
  value       = module.rbs.cloudsql_app_stairway_db_creds
  description = "Terra RBS Stairway database user credentials"
  sensitive   = true
}
output "rbs_ingress_ip" {
  value       = module.rbs.ingress_ip
  description = "Terra RBS ingress IP"
}
output "rbs_fqdn" {
  value       = module.rbs.fqdn
  description = "Terra RBS fully qualified domain name"
}
