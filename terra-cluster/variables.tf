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
  description = "The google project"
}
variable "owner" {
  description = "Environment or developer"
  default     = ""
}
locals {
  owner   = var.owner == "" ? terraform.workspace : var.owner
  service = "terra"
}


#
# k8s Vars
#
variable "cluster_location" {
  type    = string
  default = "us-central1-a"
}
variable "cluster_name" {
  type    = string
  default = ""
}

locals {
  cluster_name = var.cluster_name == "" ? "${local.service}-${local.owner}" : var.cluster_name
  # Derive cluster region from location (which could be zone or region)
  cluster_region = regex("^(\\w+-\\w+)(-|$)", var.cluster_location)[0]
}

# Network settings
variable "use_short_network_names" {
  description = "Whether to use short network names for VPC/subet/etc resources"
  type        = bool
  default     = false
}

locals {
  region_nicks = {
    "us-central1" = "us-cn1"
  }
  region_nick = local.region_nicks[local.cluster_region]
  short_names = { # Backwards-compatibility for terra-integration cluster
    network = local.cluster_name
    subnet  = local.cluster_name
    router  = local.cluster_name
    nat     = local.cluster_name
  }
  # These names approximate the conventions suggested here:
  #   https://cloud.google.com/solutions/best-practices-vpc-design#naming
  long_names = {
    network = "${var.google_project}-vpc"
    subnet  = "${var.google_project}-${local.region_nick}-gke-${local.cluster_name}-subnet"
    router  = "${var.google_project}-${local.region_nick}-router"
    nat     = "${var.google_project}-${local.region_nick}-router-nat"
  }
  names = var.use_short_network_names ? local.short_names : local.long_names
}

variable "cluster_network" {
  description = "Override default name of the cluster network"
  type        = string
  default     = ""
}
variable "cluster_subnet" {
  description = "Override default name of the cluster subnet"
  type        = string
  default     = ""
}

locals {
  cluster_network = var.cluster_network == "" ? local.names.network : var.cluster_network
  cluster_subnet  = var.cluster_subnet == "" ? local.names.subnet : var.cluster_subnet
}

# When it comes time to make a new GKE cluster, allocate unique subnets in the
# VPC Subnets spreadsheet:
# https://docs.google.com/spreadsheets/d/1BNkhLEhtqfB2KyXEbKpD3fHnOKgxCJGdGd3DiABUJBU/edit#gid=1629133233
#
# We want to avoid subnet overlap in order to make it possible to peer VPCs.
variable "create_network" {
  description = "Whether to create a new VPC network or use an existing one"
  type        = bool
  default     = true
}
variable "create_nat_gateway" {
  description = "Whether to create a NAT gateway for the cluster"
  type        = bool
  default     = true
}
variable "auto_create_subnets" {
  description = "DEPRECATED: Let Google automatically create subnets for the GKE cluster"
  type        = bool
  default     = false
}
variable "nodes_subnet_ipv4_cidr_block" {
  description = "CIDR range for the cluster's primary subnet"
  type        = string
  default     = "0.0.0.0/32"
}
variable "pods_subnet_ipv4_cidr_block" {
  description = "Secondary CIDR range for the cluster's pods"
  type        = string
  default     = "0.0.0.0/32"
}
variable "services_subnet_ipv4_cidr_block" {
  description = "Secondary CIDR range for the cluster's services"
  type        = string
  default     = "0.0.0.0/32"
}
variable "private_master_ipv4_cidr_block" {
  description = "CIDR range for private cluster master endpoint"
  type        = string
  default     = "0.0.0.0/28"
}
variable "nat_egress_ip_count" {
  description = "Number of Cloud NAT IPs to create for cluster egress"
  type        = number
  default     = 2
}
variable "authorized_network_cidrs" {
  description = "Array of CIDR blocks for authorized networks"
  type        = list(string)
  default     = []
}

variable "cloud_nat_settings" {
  description = "Cloud NAT settings"
  type        = object({ min_ports_per_vm = number })
  default = {
    min_ports_per_vm = 64
  }
}

# Istio
variable "istio_enable" {
  description = "Whether to enable Google's Istio implementation in the cluster"
  type        = bool
  default     = true
}

variable "release_channel" {
  type        = string
  description = "See official documentation for GKE release channels"
  default     = "REGULAR"
}
variable "k8s_version_prefix" {
  type        = string
  description = "Passed to k8s-cluster module to set minimum cluster version"
}

variable "node_pool_default_v2_autoscaling" {
  description = "Range of nodes in default-v2 pool"
  type        = object({ min_node_count = number, max_node_count = number })
}

variable "node_pool_cronjob_v1_autoscaling" {
  description = "Range of nodes in cronjob-v1 pool"
  type        = object({ min_node_count = number, max_node_count = number })
}

variable "node_pool_cromwell_v1_autoscaling" {
  description = "Range of nodes in cromwell-v1 pool"
  type        = object({ min_node_count = number, max_node_count = number })
}

variable "node_pool_default_node_count" {
  description = "Number of nodes default pool"
  type        = number
}

variable "node_pool_highmem_node_count" {
  description = "Number of nodes in highmem pool"
  type        = number
}

#
# CI SA vars
#
locals {
  ci_sa_roles = [
    "roles/storage.admin",
    "roles/container.admin"
  ]
}

# Which projects to give the node pool service account the 'roles/storage.objectViewer' role. The node service account
# needs this read access to pull images from Google Container Registry for projects other than its own.
variable "other_gcr_projects" {
  type        = list(string)
  default     = []
  description = "List of projects with GCR that the k8s node pool needs access to for pulling images."
}


#
# Monitoring Variables
#
variable "notification_channels" {
  type        = list(string)
  default     = []
  description = "A list of ids for channels to contact when an alert fires"
}

variable "stackdriver_workspace_project" {
  type        = string
  default     = "broad-dsp-stackdriver"
  description = "The stackdriver workspace that monitors the legacy firecloud environments except broad-dsde-prod."
}

variable "use_legacy_stackdriver_workspace" {
  type        = bool
  default     = false
  description = "Flag that should be enabled only if you are creating a cluster in one of the legacy firecloud gcp projects: broad-dsde-[dev/alpha/perf/staging]"
}

# DNS Vars
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
