# Docker instance(s)
module "app_server" {
  enable_flag = var.create_app_server ? "1" : "0"

  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/docker-instance-data-disk?ref=docker-instance-data-disk-0.2.3-tf-0.12"

  providers = {
    google.target = google.target
  }

  project                 = var.google_project
  instance_name           = var.service
  instance_num_hosts      = 1
  instance_size           = var.app_instance_size
  instance_image          = var.app_instance_image
  instance_data_disk_size = var.app_instance_data_disk_size
  instance_data_disk_type = var.app_instance_data_disk_type
  instance_data_disk_name = "${var.service}-data-disk"
  instance_service_account = var.create_sa ? google_service_account.app[0].email : (
    local.app_sa_default ? data.google_compute_default_service_account.app[0].email : data.google_service_account.app[0].email
  )
  instance_network_name = local.network_name
  instance_tags         = local.app_instance_tags
  instance_labels       = local.app_instance_labels

  dependencies = [
    google_compute_network.vpc_network,
    module.enable-services,
    module.mongodb
  ]
}

module "load-balancer" {
  enable_flag = var.create_lb ? 1 : 0

  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/http-load-balancer?ref=gm-lb-security-policy"

  providers = {
    google.target = google.target
  }
  project            = var.google_project
  load_balancer_name = "${var.service}-${local.owner}"

  ssl_policy_name                 = google_compute_ssl_policy.policy.name
  load_balancer_ssl_policy_create = var.create_lb ? 1 : 0
  load_balancer_ssl_certificates  = var.create_lb ? var.lb_ssl_certs : []
  load_balancer_health_check_path = "/single_cell"
  load_balancer_instance_groups   = var.create_lb ? element(module.app_server.instance_instance_group, 0) : ""
  load_balancer_rules             = var.lb_rules
}
