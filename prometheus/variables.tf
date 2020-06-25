# General vars
variable "google_project" {
  description = "The google project"
}

variable "environment" {
  description = "Environment or developer"
  default     = ""
}

locals {
  owner     = var.environment == "integration" ? "integ" : terraform.workspace
  service   = "prometheus"
  subdomain = "${local.service}.${local.owner}"
}


# DNS vars
variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
  default     = "dsp-envs"
}

variable "enable" {
  type        = bool
  description = "enable prometheus server ingress reources"
  default     = true
}
