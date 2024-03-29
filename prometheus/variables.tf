# General vars
variable "environment" {
  type        = string
  description = "Environment or developer"
  default     = ""
}

variable "google_project" {
  type        = string
  description = "The google project in which to create resources"
}

variable "dns_project" {
  type        = string
  description = "Host project for mcterra dns"
  default     = "dsp-devops"
}

variable "k8s_namespace" {
  type        = string
  description = "Kubernetes namespace that hosts prometheus deployments"
  default     = "monitoring"
}

locals {
  owner     = var.environment == "integration" ? "integ" : terraform.workspace
  service   = "prometheus"
  subdomain = var.use_subdomain ? "${local.service}.${local.owner}" : local.service
  project   = var.use_subdomain ? var.dns_project : var.google_project
}

variable "enable" {
  type        = bool
  description = "enable prometheus server ingress reources"
  default     = true
}

variable "enable_thanos" {
  type        = bool
  description = "whether to create networking resources for exposing thanos sidecar. This is used to aggregate across multiple prometheuses"
  default     = false
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
