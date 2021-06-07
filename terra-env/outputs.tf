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
output "sam_firestore_sa_email" {
  value       = module.sam.firestore_sa_email
  description = "Sam Firestore Google service account email"
}
output "sam_firestore_project_name" {
  value       = module.sam.firestore_project_name
  description = "Sam Firestore project name"
}
output "sam_ingress_ip" {
  value       = module.sam.ingress_ip
  description = "Sam ingress IP"
}
output "sam_ingress_ip_name" {
  value       = module.sam.ingress_ip_name
  description = "Sam ingress IP name"
}
output "sam_fqdn" {
  value       = module.sam.fqdn
  description = "Sam fully qualified domain name"
}

#
# Workspace Manager Outputs
#
output "workspace_sqlproxy_sa_id" {
  value       = module.workspace_manager.sqlproxy_sa_id
  description = "Workspace Manager Cloud SQL Proxy Google service account ID"
}
output "workspace_app_sa_id" {
  value       = module.workspace_manager.app_sa_id
  description = "Workspace Manager App Google service account ID"
}
output "workspace_cloudsql_pg13_outputs" {
  value       = module.workspace_manager.cloudsql_pg13_outputs
  description = "Workspace Manager CloudSQL Postgres 13 instance outputs"
}
output "workspace_ingress_ip" {
  value       = module.workspace_manager.ingress_ip
  description = "Workspace Manager ingress IP"
}
output "workspace_ingress_ip_name" {
  value       = module.workspace_manager.ingress_ip_name
  description = "Workspace Manager ingress IP name"
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
  value = contains(["preview"], var.env_type) ? {
    workspacemanager = local.terra_apps["workspace_manager"] ? module.workspace_manager.ingress_ip : null
  } : null
  description = "Service ingress IPs"
}
output "fqdns" {
  value = contains(["preview"], var.env_type) ? {
    workspacemanager = local.terra_apps["workspace_manager"] ? module.workspace_manager.fqdn : null
  } : null
  description = "Service fully qualified domain names"
}

#
# Terra Resource Buffering Service Outputs
#
output "buffer_sa_id" {
  value       = module.buffer.app_sa_id
  description = "Terra Resource Service Google service account ID"
}
output "buffer_sqlproxy_sa_id" {
  value       = module.buffer.sqlproxy_sa_id
  description = "Terra Resource Buffer Service Cloud SQL Proxy Google service account ID"
}
output "buffer_client_sa_id" {
  value       = module.buffer.client_sa_id
  description = "Terra Resource Buffer Service client Google service account ID"
}
output "buffer_db_ip" {
  value       = module.buffer.cloudsql_public_ip
  description = "Terra Buffer Service CloudSQL instance IP"
}
output "buffer_db_instance" {
  value       = module.buffer.cloudsql_instance_name
  description = "Terra Buffer Service CloudSQL instance name"
}
output "buffer_db_root_pass" {
  value       = module.buffer.cloudsql_root_user_password
  description = "Terra Buffer Service database root password"
  sensitive   = true
}
output "buffer_db_creds" {
  value       = module.buffer.cloudsql_app_db_creds
  description = "Terra Buffer Service database user credentials"
  sensitive   = true
}
output "buffer_stairway_db_creds" {
  value       = module.buffer.cloudsql_app_stairway_db_creds
  description = "Terra Buffer Service Stairway database user credentials"
  sensitive   = true
}
output "buffer_ingress_ip" {
  value       = module.buffer.ingress_ip
  description = "Terra Buffer Service ingress IP"
}
output "buffer_ingress_ip_name" {
  value       = module.buffer.ingress_ip_name
  description = "Terra Buffer Service ingress IP name"
}
output "buffer_fqdn" {
  value       = module.buffer.fqdn
  description = "Terra Buffer Service fully qualified domain name"
}
output "buffer_pool_name_to_folder_id" {
  // Lookup each variable in the pool_names input list in the generated folders map. This relies on the pool_name being each.key in the
  // for_each in folder.tf
  value       = module.buffer.pool_name_to_folder_id
  description = "Map from pool name to the folder that will contain all projects created for the pool. Only populated for pools in the pool_names input variable."
}
#
# Consent Outputs
#
output "consent_ingress_ip" {
  value       = module.consent.ingress_ip
  description = "Static ip for consent LB"
}

output "consent_fqdn" {
  value       = module.consent.fqdn
  description = "fqdn to access k8s consent deployment"
}

#
# Rawls Outputs
#
output "rawls_ingress_ip" {
  value       = module.rawls.ingress_ip
  description = "Static ip for rawls LB"
}

output "rawls_fqdn" {
  value       = module.rawls.fqdn
  description = "fqdn to access k8s rawls deployment"
}

#
# Leonardo Outputs
#
output "leonardo_ingress_ip" {
  value       = module.leonardo.ingress_ip
  description = "Static ip for leonardo LB"
}

output "leonardo_fqdn" {
  value       = module.leonardo.fqdn
  description = "fqdn to access k8s leonardo deployment"
}

#
# Firecloud Orchestration Outputs
#

output "firecloudorch_ingress_ip" {
  value       = module.firecloudorch.ingress_ip
  description = "Static if for orchestration lb"
}

output "firecloudorch_fqdn" {
  value       = module.firecloudorch.fqdn
  description = "fqdn to acess orchestration deployment"
}
