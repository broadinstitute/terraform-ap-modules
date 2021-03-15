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
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.3-tf-0.12"
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
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.3-tf-0.12"
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
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.3-tf-0.12"
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
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.3-tf-0.12"
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
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.3-tf-0.12"
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

# opendj node pool
module "k8s-node-pool-opendj" {
  # boilerplate
  enable = var.node_pool_opendj.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.3-tf-0.12"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name = "opendj"
  autoscaling = {
    min_node_count = var.node_pool_opendj.min_node_count
    max_node_count = var.node_pool_opendj.max_node_count
  }
  machine_type = "custom-80-81920"
  disk_size_gb = 200
  labels       = { "bio.terra/node-pool" = "opendj" }
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-opendj"])
  taints       = [{ key = "bio.terra/workload", value = "opendj", effect = "NO_SCHEDULE" }]
}

# MongoDB node pool
module "k8s-node-pool-mongodb-v1" {
  # boilerplate
  enable = var.node_pool_mongodb_v1.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.4-tf-0.12"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name = "mongodb-v1"
  autoscaling = {
    min_node_count = var.node_pool_mongodb_v1.min_node_count
    max_node_count = var.node_pool_mongodb_v1.max_node_count
  }

  # MongoDB requires XFS filesystem, so we need to use Ubuntu
  # https://cloud.google.com/kubernetes-engine/docs/concepts/node-images#ubuntu
  image_type = "ubuntu_containerd"

  machine_type = "n1-highmem-4"
  disk_size_gb = 200
  labels       = { "bio.terra/node-pool" = "mongodb" }
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-mongodb-v1"])
  taints       = [{ key = "bio.terra/workload", value = "mongodb", effect = "NO_SCHEDULE" }]

  enable_secure_boot = true
}

# Elasticsearch Node Pool
module "k8s-node-pool-elasticsearch-v1" {
  # boilerplate
  enable = var.node_pool_opendj.enable
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/k8s-node-pool?ref=k8s-node-pool-0.2.4-tf-0.12"
  dependencies = [
    module.k8s-master
  ]
  service_account = google_service_account.node_pool.email
  master_name     = module.k8s-master.name
  location        = var.cluster_location

  # pool-specific settings
  name = "elasticsearch-v1"
  autoscaling = {
    min_node_count = var.node_pool_elasticsearch_v1.min_node_count
    max_node_count = var.node_pool_elasticsearch_v1.max_node_count
  }

  machine_type = "n1-standard-2"
  disk_size_gb = 200
  labels       = { "bio.terra/node-pool" = "elasticsearch" }
  tags         = setunion(local.default_node_tags, ["k8s-${module.k8s-master.name}-node-elasticsearch-v1"])
  taints       = [{ key = "bio.terra/workload", value = "elasticsearch", effect = "NO_SCHEDULE" }]

  enable_secure_boot = true
}
