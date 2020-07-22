resource "google_compute_network" "k8s-cluster-network" {
  count                   = var.create_network ? 1 : 0
  provider                = google-beta.target
  project                 = var.google_project
  name                    = local.cluster_network
  auto_create_subnetworks = var.auto_create_subnets
  depends_on              = [module.enable-services]
}

data "google_compute_network" "existing-vpc-network" {
  name = local.cluster_network
}

locals {
  cluster_network_id        = var.create_network ? google_compute_network.k8s-cluster-network[0].id : data.google_compute_network.existing-vpc-network.id
  cluster_network_self_link = var.create_network ? google_compute_network.k8s-cluster-network[0].self_link : data.google_compute_network.existing-vpc-network.self_link
}

# Make it possible to use `gcloud ssh` to access nodes
# on the VPC network
resource "google_compute_firewall" "allow-ssh-iap" {
  name    = "allow-ssh-from-iap"
  network = local.cluster_network
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_subnetwork" "k8s-cluster-subnet" {
  count                    = var.auto_create_subnets ? 0 : 1
  name                     = local.cluster_subnet
  network                  = local.cluster_network_self_link
  region                   = local.cluster_region
  ip_cidr_range            = var.nodes_subnet_ipv4_cidr_block
  private_ip_google_access = true

  secondary_ip_range = [
    {
      range_name    = "pods"
      ip_cidr_range = var.pods_subnet_ipv4_cidr_block
    },
    {
      range_name    = "services"
      ip_cidr_range = var.services_subnet_ipv4_cidr_block
  }]
}

#
# Set up private services access
# https://cloud.google.com/vpc/docs/configure-private-services-access
# So that apps can talk to private CloudSQL instances
#
locals {
  peering_range_cidr             = split("/", var.private_services_access_cidr_block)
  peering_range_starting_address = peering_range_cidr[0]
  peering_range_prefix_length    = parseint(peering_range_cidr[1])
}

resource "google_compute_global_address" "private-services-range" {
  count         = var.private_services_access_enabled ? 1 : 0
  name          = "${local.cluster_network}-private-services"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  network       = local.cluster_network_id
  address       = local.peering_range_starting_address
  prefix_length = local.peering_range_prefix_length
}

resource "google_service_networking_connection" "private-services-peering-connection" {
  count                   = var.private_services_access_enabled ? 1 : 0
  network                 = local.cluster_network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private-services-range.name]
}
