locals {
  default_node_tags = ["k8s-${module.k8s-master.name}-node-${local.node_pools.default.name}"]
}

# Default node pool
module "k8s-node-pool" {
  # terraform-shared repo
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.1.0-tf-0.12"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email

  name        = local.node_pools.default.name
  master_name = module.k8s-master.name
  location    = var.cluster_location

  node_count   = local.node_pools.default.node_count
  machine_type = local.node_pools.default.machine_type
  disk_size_gb = local.node_pools.default.disk_size_gb

  labels = local.node_pools.default.labels
  tags   = setunion(local.default_node_tags, local.node_pools.default.tags)
}

# Highmem pool
module "k8s-node-pool-highmem" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.1.0-tf-0.12"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email

  name        = local.node_pools.highmem.name
  master_name = module.k8s-master.name
  location    = var.cluster_location

  node_count   = local.node_pools.highmem.node_count
  machine_type = local.node_pools.highmem.machine_type
  disk_size_gb = local.node_pools.highmem.disk_size_gb

  labels = local.node_pools.highmem.labels
  tags   = setunion(local.default_node_tags, local.node_pools.highmem.tags)
}
