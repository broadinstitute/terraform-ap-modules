module "k8s-master" {
  # terraform-shared repo
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-master?ref=k8s-master-0.2.3-tf-0.12"
  dependencies = [
    module.enable-services,
    google_compute_network.k8s-cluster-network
  ]

  name            = local.cluster_name
  location        = var.cluster_location
  version_prefix  = var.k8s_version_prefix
  release_channel = var.release_channel

  network                 = local.cluster_network
  subnetwork              = var.auto_create_subnets ? local.cluster_network : local.cluster_subnet
  private_ipv4_cidr_block = var.private_master_ipv4_cidr_block

  authorized_network_cidrs = var.authorized_network_cidrs

  ip_allocation_policy = {
    cluster_secondary_range_name  = var.auto_create_subnets ? null : "pods"
    services_secondary_range_name = var.auto_create_subnets ? null : "services"
  }

  istio_enable = var.istio_enable

  enable_shielded_nodes = true
}
