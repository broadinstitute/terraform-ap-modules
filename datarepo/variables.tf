variable "dependencies" {
  # See: https://github.com/hashicorp/terraform/issues/21418#issuecomment-495818852
  type        = any
  default     = []
  description = "Work-around for Terraform 0.12's lack of support for 'depends_on' in custom modules."
}
variable "enable" {
  type        = bool
  description = "Enable flag for this module. If set to false, no resources will be created."
  default     = true
}
variable "owner" {
  type        = string
  description = "Environment or developer. Defaults to TF workspace name if left blank."
  default     = ""
}
locals {
  owner = var.owner == "" ? terraform.workspace : var.owner
}

#
# DNS Vars
#
variable "hostname" {
  type        = string
  description = "DNS hostname"
  default     = "data"
}
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
  default     = ""
}
variable "dns_zone_project" {
  type        = string
  description = "DNS zone project"
  default     = ""
}

variable "static_ip_name" {
  type        = string
  description = "Name of Data Repo's static IP"
}
variable "static_ip_project" {
  type        = string
  description = "The google project where Data Repo's static IP lives"
}
