locals {
  default_node_tags = ["k8s-${module.k8s-master.name}-node"]
  legacy_node_tags  = ["k8s-${module.k8s-master.name}-node-default"]
}

# default-v2 node pool
module "k8s-node-pool-default-v2" {
  # boilerplate
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=ch-autoscaling" # k8s-node-pool-0.2.0-tf-0.12
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name         = "default-v2"
  autoscaling  = var.node_pool_default_v2_autoscaling
  machine_type = "n1-standard-16"
  disk_size_gb = 200
  labels       = []
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-${module.k8s-node-pool-default-v2.name}"])
}

# cronjob-v1 node pool
module "k8s-node-pool-cronjob-v1" {
  # boilerplate
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=ch-autoscaling"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name         = "cronjob-v1"
  autoscaling  = var.node_pool_cronjob_v1_autoscaling
  machine_type = "n1-standard-4"
  disk_size_gb = 200
  labels       = []
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-${module.k8s-node-pool-cronjob-v1.name}"])
}

# old default node pool - deprecated
module "k8s-node-pool" {
  # boilerplate
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=ch-autoscaling"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name         = "default"
  node_count   = var.node_pool_default_node_count
  machine_type = "n1-standard-4"
  disk_size_gb = 200
  labels       = { test_label_foo = "test_label_bar" } # These can't be changed without deleting the node pool
  tags         = local.legacy_node_tags
}

# highmem node pool - currently used for running Cromwell
module "k8s-node-pool-highmem" {
  # boilerplate
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=ch-autoscaling"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name         = "highmem"
  node_count   = var.node_pool_highmem_node_count
  machine_type = "n1-highmem-8"
  disk_size_gb = 200
  labels       = {}
  # This is incorrect, but we can't update the node tags on an existing pool,
  # so we're stuck until we build out a new pool
  tags = local.legacy_node_tags
}
