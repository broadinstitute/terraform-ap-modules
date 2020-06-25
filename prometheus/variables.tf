# General vars
variable "environment" {
  description = "Environment or developer"
  default     = ""
}

variable "google_project" {
  description = "The google project"
}

variable "dns_project" {
  type        = string
  description = "Host project for mcterra dns"
  default     = "dsp-devops"
}

locals {
  owner     = var.environment == "integration" ? "integ" : var.use_subdomain ? terraform.workspace : "dsde-${terraform.workspace}"
  service   = "prometheus"
  subdomain = "${local.service}.${local.owner}"
  project   = var.use_subdomain ? var.dns_project : var.google_project
}

variable "enable" {
  type        = bool
  description = "enable prometheus server ingress reources"
  default     = true
}

# DNS vars
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
  default     = "dsp-envs"
}
variable "subdomain_name" {
  type        = string
  description = "Domain namespacing between zone and hostname"
  default     = ""
}
variable "use_subdomain" {
  type        = bool
  description = "Whether to use a subdomain between the zone and hostname"
  default     = true
}

