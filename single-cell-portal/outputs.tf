#
# MongoDB Outputs
#

output "mongodb_instance_public_ips" {
  value       = module.mongodb.instance_public_ips
  description = "MongoDB public IPs"
}
output "mongodb_instance_private_ips" {
  value       = module.mongodb.instance_private_ips
  description = "MongoDB private IPs"
}
output "mongodb_instance_names" {
  value       = module.mongodb.instance_names
  description = "MongoDB instance names"
}
output "mongodb_instance_hostnames" {
  value       = module.mongodb.instance_hostnames
  description = "MongoDB instance hostnames"
}
output "mongodb_instance_priv_hostnames" {
  value       = module.mongodb.instance_priv_hostnames
  description = "MongoDB internal hostnames"
}
output "mongodb_uri" {
  value       = module.mongodb.mongo_uri
  description = "MongoDB URI"
  sensitive   = true
}
output "mongodb_priv_uri" {
  value       = module.mongodb.mongo_priv_uri
  description = "MongoDB internal URI"
  sensitive   = true
}
output "mongodb_instance_instance_group" {
  value       = module.mongodb.instance_instance_group
  description = "MongoDB instance group"
}
output "mongodb_config_bucket_name" {
  value       = module.mongodb.config_bucket_name
  description = "MongoDB configuration bucket name"
}
output "mongodb_root_password" {
  value       = random_id.mongodb_root_password.hex
  description = "MongoDB root password"
  sensitive   = true
}
output "mongodb_app_user" {
  value       = var.mongodb_user
  description = "MongoDB app username"
}
output "mongodb_app_password" {
  value       = random_id.mongodb_user_password.hex
  description = "MongoDB app password"
  sensitive   = true
}


#
# App Server Ouputs
#

output "app_instance_public_ips" {
  value       = module.app_server.instance_public_ips
  description = "App instance public IPs"
}
output "app_instance_private_ips" {
  value       = module.app_server.instance_private_ips
  description = "App instance private IPs"
}
output "app_instance_group" {
  value       = module.app_server.instance_instance_group
  description = "App instance group"
}
output "app_lb_public_ip" {
  value       = var.create_lb ? module.load-balancer.load_balancer_public_ip[0] : ""
  description = "App load balancer public IP"
}
