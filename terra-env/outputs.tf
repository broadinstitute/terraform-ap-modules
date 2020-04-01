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
output "sam_sa_id" {
  value = module.sam.service_account_id
}
output "sam_admin_sdk_sA_ids" {
  value = module.sam.admin_sdk_service_account_ids
}
