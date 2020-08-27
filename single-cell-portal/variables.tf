# See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
variable dependencies {
  type        = any
  default     = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}


#
# General Vars
#
variable "google_project" {
  type        = string
  description = "The google project in which to create resources"
}
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}
variable "service" {
  description = "App name"
  default     = "singlecell"
}


#
# Service Account Vars
#
variable "create_sa" {
  type        = bool
  description = "Whether to create and manage the SAs in TF or use existing ones"
  default     = true
}
variable "app_sa_name" {
  type        = string
  description = "Application service account"
  default     = ""
}
locals {
  app_sa_name = var.app_sa_name == "" ? "${var.service}-${local.owner}" : var.app_sa_name
  # Checks if the SA being used is a default compute SA, since we need a different TF data source for it
  app_sa_default = length(regexall("\\d+-compute", var.app_sa_name)) > 0
}
variable "app_sa_roles" {
  type        = list(string)
  description = "Roles that the app Google service account is granted"
  default = [
    "roles/compute.viewer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter"
  ]
}
variable "app_read_sa_name" {
  type        = string
  description = "Application read service account. Defaults to singlecell-[env]-read if left blank."
  default     = ""
}
locals {
  app_read_sa_name = var.app_read_sa_name == "" ? "${var.service}-${local.owner}-read" : var.app_read_sa_name
}
variable "app_read_sa_roles" {
  type        = list(string)
  description = "Roles that the app read Google service account is granted"
  default = [
    "roles/storage.objectViewer"
  ]
}


#
# Network Vars
#
variable "network_name" {
  type        = string
  default     = ""
  description = "The network name. Defaults to singlecell"
}
variable "create_network" {
  type        = bool
  description = "Whether to create and manage the network in TF or use an existing one"
  default     = true
}
locals {
  network_name = var.network_name == "" ? var.service : var.network_name
}

#
# Firewall Vars
#
variable "enable_logging" {
  type        = bool
  description = "Whether to enable logging in firewall rules"
  default     = false
}
variable "allow_travis" {
  type        = bool
  description = "Whether to allow Travis CI runners to communicate with MongoDB"
  default     = false
}
variable "internal_range" {
  type        = string
  description = "Internal IP space for networks that use auto created subnets"
  default     = "10.128.0.0/9"
}
variable "corp_range_cidrs" {
  description = "Company internal network CIDRs"
  type        = list(string)
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
  type        = list(string)
  default = [
    // SCP Jenkins
    "35.232.118.163/32",
    "130.211.234.92"
  ]
}
variable "gcp_health_check_range_cidrs" {
  description = "CI/CD IPs"
  type        = list(string)
  default = [
    // https://cloud.google.com/load-balancing/docs/health-check-concepts#ip-ranges
    "35.191.0.0/16",
    "130.211.0.0/22",
    "209.85.152.0/22",
    "209.85.204.0/22"
  ]
}


#
# MongoDB Vars
#
variable "mongodb_roles" {
  type = list(string)
  default = [
    "primary"
  ]
  description = "host roles that will be present in this cluster"
}
variable "mongodb_version" {
  type    = string
  default = "3.6.14"
}
variable "mongodb_user" {
  type    = string
  default = "single_cell"
}
variable "mongodb_database" {
  type    = string
  default = "single_cell_portal_development"
}
variable "mongodb_instance_size" {
  type        = string
  default     = "n1-highmem-2"
  description = "The default size of MongoDB hosts"
}
variable "mongodb_instance_image" {
  type        = string
  default     = "centos-7"
  description = "The default image of MongoDB hosts"
}
variable "mongodb_instance_count_offset" {
  default     = 0
  type        = number
  description = "Offset at which to start naming suffix"
}
variable "mongodb_instance_group_name" {
  default     = null
  type        = string
  description = "Name of mongo instance group. Defaults to singelcell-mongo-instance-group-unmanaged"
}
variable "mongodb_instance_data_disk_size" {
  type        = string
  default     = "200"
  description = "The default size of MongoDB data disk"
}
variable "mongodb_instance_data_disk_type" {
  type        = string
  default     = "pd-ssd"
  description = "The default type of MongoDB data disk"
}
variable "mongodb_dns" {
  type        = bool
  description = "Whether to create DNS entries"
  default     = false
}
locals {
  mongodb_instance_tags = [
    "${var.service}-mongodb-${local.owner}",
    "http-server",
    "https-server",
    "mongodb"
  ]
}
locals {
  mongodb_instance_labels = {
    "app"             = "${var.service}-mongo",
    "owner"           = local.owner,
    "role"            = "db",
    "ansible_branch"  = "master",
    "ansible_project" = var.service
  }
}
variable "mongodb_extra_flags" {
  type        = string
  description = "Extra flags passed to the mongo container. https://github.com/bitnami/bitnami-docker-mongodb#passing-extra-command-line-flags-to-mongod-startup"
  default     = null
}

#
# App Server Vars
#
variable "create_app_server" {
  type        = bool
  description = "Whether to create & manage an app server in TF"
  default     = false
}
variable "app_instance_size" {
  type        = string
  default     = "n1-highmem-4"
  description = "The default size of app hosts"
}
variable "app_instance_image" {
  type        = string
  default     = "centos-7"
  description = "The default image of app hosts"
}
variable "app_instance_data_disk_size" {
  type        = string
  default     = "100"
  description = "The default size of app data disk"
}
variable "app_instance_data_disk_type" {
  type        = string
  default     = "pd-ssd"
  description = "The default type of app data disk"
}
locals {
  app_instance_tags = [
    "${var.service}-${local.owner}",
    var.service,
    "http-server",
    "https-server",
    "gce-lb-instance-group-member",
  ]
}
locals {
  app_instance_labels = {
    "app"             = var.service,
    "owner"           = local.owner,
    "role"            = "app-server",
    "ansible_branch"  = "master",
    "ansible_project" = var.service
  }
}


#
# App Server LB/SSL Vars
#
variable "create_lb" {
  type        = bool
  description = "Whether to create & manage a load balancer for the app server"
  default     = false
}
variable "lb_ssl_certs" {
  type        = list(string)
  description = "Self links of ssl certs to use for the load balancer. Required if create_lb is true."
  default     = []
}
variable "ssl_policy_name" {
  type        = string
  description = "Name of ssl cert to use for the load balancer. Defaults to singlecell-[env]"
  default     = ""
}
locals {
  ssl_policy_name = var.ssl_policy_name == "" ? "${var.service}-${local.owner}" : var.ssl_policy_name
}
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name for load balancer DNS. Required if create_lb is true."
  default     = ""
}
variable "lb_dns_name" {
  type        = string
  description = "DNS name for load balancer. Required if create_lb is true."
  default     = ""
}
variable "lb_dns_ttl" {
  type        = string
  description = "DNS ttl for load balancer"
  default     = "300"
}
variable "lb_rules" {
  description = "List of security policy rules to apply to LB"
  type = set(object({
      action=string,
      priority=string,
      ip_ranges=list(string),
      description=string
    })
  )
  default = []
}
