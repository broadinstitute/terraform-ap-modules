# See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
variable dependencies {
  type = any
  default = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}


#
# General Vars
#
variable "google_project" {
  description = "The google project"
}
variable "owner" {
  description = "Environment or developer"
  default = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
variable "service" {
  description = "App name"
  default = "singlecell"
}


#
# Service Account Vars
#
variable "create_sa" {
  description = "Whether to create and manage the SAs in TF or use an existing one"
  default = true
}
variable "app_sa_name" {
  description = "Application service account"
  default = ""
}
locals {
  app_sa_name = var.app_sa_name == "" ? "${var.service}-${local.owner}" : var.app_sa_name
}
variable "app_sa_roles" {
  default = [
    "roles/compute.viewer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter"
  ]
}
variable "app_read_sa_name" {
  description = "Application read service account"
  default = ""
}
locals {
  app_read_sa_name = var.app_read_sa_name == "" ? "${var.service}-${local.owner}-read" : var.app_read_sa_name
}
variable "app_read_sa_roles" {
  default = [
    "roles/storage.objectViewer"
  ]
}


#
# Network Vars
#
variable "network_name" {
  default = ""
  description = "The network name"
}
variable "create_network" {
  description = "Whether to create and manage the network in TF or use an existing one"
  default = true
}
locals {
  network_name = var.network_name == "" ? var.service : var.network_name
}

#
# Firewall Vars
#
variable "enable_logging" {
  default = false
}
variable "internal_range" {
  description = "Internal IP space for networks that use auto created subnets"
  default = "10.128.0.0/9"
}
variable "corp_range_cidrs" {
  description = "Company internal network CIDRs"
  type    = list(string)
  default = [
    // Broad internal
    "69.173.64.0/19", 
    "69.173.96.0/20",
    "69.173.112.0/21",
    "69.173.120.0/22",
    "69.173.124.0/23",
    "69.173.126.0/24",
    "69.173.127.0/25",
    "69.173.127.128/26",
    "69.173.127.192/27",
    "69.173.127.224/30",
    "69.173.127.228/32",
    "69.173.127.230/31",
    "69.173.127.232/29",
    "69.173.127.240/28" 
  ]
}
variable "ci_range_cidrs" {
  description = "CI/CD IPs"
  type    = list(string)
  default = [
    // SCP Jenkins
    "35.232.118.163/32",
    "130.211.234.92"
  ]
}
variable "gcp_health_check_range_cidrs" {
  description = "CI/CD IPs"
  type    = list(string)
  default = [
    // https://cloud.google.com/load-balancing/docs/health-check-concepts#ip-ranges
    "35.191.0.0/16",
    "209.85.152.0/22",
    "209.85.204.0/22"
  ]
}


#
# MongoDB Vars
#
variable "mongodb_roles" {
  default = [
    "primary"
  ]
  description = "host roles that will be present in this cluster"
}
variable "mongodb_version" {
   default = "3.6.14"
}
variable "mongodb_user" {
  default = "single_cell"
}
variable "mongodb_database" {
  default = "single_cell_portal_development"
}
variable "mongodb_instance_size" {
  default = "n1-highmem-2"
  description = "The default size of MongoDB hosts"
}
variable "mongodb_instance_image" {
  default = "centos-7"
  description = "The default image of MongoDB hosts"
}
variable "mongodb_instance_data_disk_size" {
  default = "200"
  description = "The default size of MongoDB data disk"
}
variable "mongodb_instance_data_disk_type" {
  default = "pd-ssd"
  description = "The default type of MongoDB data disk"
}
variable "mongodb_dns" {
  description = "Whether to create DNS entries"
  default = false
}
variable "mongodb_instance_tags" {
  default = []
  description = "The default MongoDB instance tags"
}
locals {
  mongodb_instance_tags = var.mongodb_instance_tags == [] ? [
    "${var.service}-mongodb-${local.owner}",
    "http-server",
    "https-server",
    "mongodb"
  ] : var.mongodb_instance_tags
}
variable "mongodb_instance_labels" {
  default = {}
  description = "The default MongoDB instance labels"
}
locals {
  mongodb_instance_labels = var.mongodb_instance_labels == {} ? {
    "app"             = "${var.service}-mongo",
    "owner"           = local.owner,
    "role"            = "db",
    "ansible_branch"  = "master",
    "ansible_project" = var.service
  } : var.mongodb_instance_labels
}

#
# App Server Vars
#
variable "create_app_server" {
  description = "Whether to create & manage an app server in TF"
  default = false
}
variable "app_instance_size" {
  default = "n1-highmem-4"
  description = "The default size of app hosts"
}
variable "app_instance_image" {
  default = "centos-7"
  description = "The default image of app hosts"
}
variable "app_instance_data_disk_size" {
  default = "100"
  description = "The default size of app data disk"
}
variable "app_instance_data_disk_type" {
  default = "pd-ssd"
  description = "The default type of app data disk"
}
variable "app_instance_tags" {
  default = []
  description = "The default app instance tags"
}
locals {
  app_instance_tags = var.app_instance_tags == [] ? [
    "${var.service}-${local.owner}",
    var.service,
    "http-server",
    "https-server",
    "gce-lb-instance-group-member",
  ] : var.mongodb_instance_tags
}
variable "app_instance_labels" {
  default = {}
  description = "The default app instance labels"
}
locals {
  app_instance_labels = var.app_instance_labels == {} ? {
    "app"             = var.service,
    "owner"           = local.owner,
    "role"            = "app-server",
    "ansible_branch"  = "master",
    "ansible_project" = var.service
  } : var.mongodb_instance_labels
}


#
# App Server LB/SSL Vars
#
variable "create_lb" {
  description = "Whether to create & manage a load balancer for the app server"
  default = false
}
variable "lb_ssl_cert" {
  description = "Self link of ssl cert to use for the load balancer"
  default = ""
}
variable "ssl_policy_name" {
  description = "Name of ssl cert to use for the load balancer"
  default = ""
}
locals {
  ssl_policy_name = var.ssl_policy_name == "" ? "${var.service}-${local.owner}" : var.ssl_policy_name
}
variable "dns_zone_name" {
  description = "DNS zone name for load balancer DNS"
  default = ""
}
variable "lb_dns_name" {
  description = "DNS name for load balancer"
  default = ""
}
variable "lb_dns_ttl" {
  description = "DNS ttl for load balancer"
  default = "300"
}
