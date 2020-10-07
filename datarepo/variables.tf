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

#
# DNS Vars
#
variable "datarepo_dns_name" {
  type        = string
  description = "DNS record name, excluding zone top-level domain. Eg. data.alpha"
  default     = ""
}

variable "grafana_dns_name" {
  type        = string
  description = "DNS record name, excluding zone top-level domain. Eg. data.alpha"
  default     = ""
}

variable "prometheus_dns_name" {
  type        = string
  description = "DNS record name, excluding zone top-level domain. Eg. data.alpha"
  default     = ""
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

variable "datarepo_static_ip_name" {
  type        = string
  description = "Name of Data Repo's static IP"
}

variable "grafana_static_ip_name" {
  type        = string
  description = "Name of Data Repo's static IP"
}

variable "prometheus_static_ip_name" {
  type        = string
  description = "Name of Data Repo's static IP"
}

variable "static_ip_project" {
  type        = string
  description = "The google project where Data Repo's static IP lives"
}
