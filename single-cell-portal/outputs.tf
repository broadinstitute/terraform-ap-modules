#
# MongoDB Outputs
#

output "mongodb_instance_public_ips" {
  value = module.mongodb.instance_public_ips
}

output "mongodb_instance_private_ips" {
  value = module.mongodb.instance_private_ips
}

output "mongodb_instance_names" {
  value = module.mongodb.instance_names
}

output "mongodb_instance_hostnames" {
  value = module.mongodb.instance_hostnames
}

output "mongodb_instance_priv_hostnames" {
  value = module.mongodb.instance_priv_hostnames
}

output "mongodb_uri" {
  value     = module.mongodb.mongo_uri
  sensitive = true
}

output "mongodb_priv_uri" {
  value     = module.mongodb.mongo_priv_uri
  sensitive = true
}

output "mongodb_instance_instance_group" {
  value = module.mongodb.instance_instance_group
}

output "mongodb_config_bucket_name" {
  value = module.mongodb.config_bucket_name
}

output "mongodb_root_password" {
  value     = random_id.mongodb_root_password.hex
  sensitive = true
}

output "mongodb_app_user" {
  value = var.mongodb_user
}

output "mongodb_app_password" {
  value     = random_id.mongodb_user_password.hex
  sensitive = true
}


#
# App Server Ouputs
#

output "app_instance_public_ips" {
  value = module.app_server.instance_public_ips
}

output "app_instance_private_ips" {
  value = module.app_server.instance_private_ips
}

output "app_instance_group" {
  value = module.app_server.instance_instance_group
}

output "app_lb_public_ip" {
  value = var.create_lb ? module.load-balancer.load_balancer_public_ip[0] : ""
}
