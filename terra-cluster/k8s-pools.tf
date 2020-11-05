# TODO - there is a lot of duplication across each k8s-node-pool module
# declaration :(
# Once we move to Terraform 0.13, we should be able to use
# a foreach for these:
#  https://github.com/hashicorp/terraform/issues/17519#issuecomment-632403492

locals {
  default_node_tags = ["k8s-${module.k8s-master.name}-node"]
  legacy_node_tags  = ["k8s-${module.k8s-master.name}-node-default"]
}

# default-v2 node pool
module "k8s-node-pool-default-v2" {
  # boilerplate
  enable = var.node_pool_default_v2.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=ch-node-pool-taints"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name = "default-v2"
  autoscaling = {
    min_node_count = var.node_pool_default_v2.min_node_count,
    max_node_count = var.node_pool_default_v2.max_node_count
  }
  machine_type = "n1-standard-16"
  disk_size_gb = 200
  labels       = { "bio.terra/node-pool" = "default" }
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-default-v2"])
}

# cronjob-v1 node pool
module "k8s-node-pool-cronjob-v1" {
  # boilerplate
  enable = var.node_pool_cronjob_v1.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=ch-node-pool-taints"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name = "cronjob-v1"
  autoscaling = {
    min_node_count = var.node_pool_cronjob_v1.min_node_count,
    max_node_count = var.node_pool_cronjob_v1.max_node_count
  }
  machine_type = "n1-standard-4"
  disk_size_gb = 200
  labels       = { "bio.terra/node-pool" = "cronjob" }
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-cronjob-v1"])
  taints       = [{ key = "bio.terra/workload", value = "cronjob", effect = "NO_SCHEDULE" }]
}

# cromwell-v1 node pool
module "k8s-node-pool-cromwell-v1" {
  # boilerplate
  enable = var.node_pool_cromwell_v1.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=ch-node-pool-taints"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name = "cromwell-v1"
  autoscaling = {
    min_node_count = var.node_pool_cromwell_v1.min_node_count
    max_node_count = var.node_pool_cromwell_v1.max_node_count
  }
  machine_type = "n1-highmem-8"
  disk_size_gb = 200
  labels       = { "bio.terra/node-pool" = "cromwell" }
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-cromwell-v1"])
  taints       = [{ key = "bio.terra/workload", value = "cromwell", effect = "NO_SCHEDULE" }]
}

# old default node pool - deprecated, will be succeeded by default-v2
module "k8s-node-pool" {
  # boilerplate
  enable = var.node_pool_default.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.2-tf-0.12"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name         = "default"
  node_count   = var.node_pool_default.node_count
  machine_type = "n1-standard-4"
  disk_size_gb = 200
  labels       = { test_label_foo = "test_label_bar" } # These can't be changed without deleting the node pool
  tags         = local.legacy_node_tags
}

# highmem node pool - deprecated, will be succeeded by cromwell-v1
module "k8s-node-pool-highmem" {
  # boilerplate
  enable = var.node_pool_highmem.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.2-tf-0.12"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name         = "highmem"
  node_count   = var.node_pool_highmem.node_count
  machine_type = "n1-highmem-8"
  disk_size_gb = 200
  labels       = {}
  # This is incorrect, but we can't update the node tags on an existing pool,
  # so we're stuck until we build out a new pool
  tags = local.legacy_node_tags
}
