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

  dynamic "log_config" {
    for_each = local.enable_flow_logs
    # Default Settings
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

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
