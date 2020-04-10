resource "random_id" "mongodb_user_password" {
  byte_length   = 16
}

resource "random_id" "mongodb_root_password" {
  byte_length   = 16
}

module "mongodb" {
  source        = "github.com/broadinstitute/terraform-shared.git//terraform-modules/mongodb?ref=mongodb-cluster-0.1.5-tf-0.12"

  providers = {
    google.target = google.target,
    google.dns =  google.dns
  }
  project                  = var.google_project
  owner                    = local.owner
  service                  = "${var.service}-mongo"
  mongodb_image_tag        = var.mongodb_version
  mongodb_service_account  = google_service_account.app[0].email
  mongodb_roles            = var.mongodb_roles
  mongodb_app_username     = var.mongodb_user
  mongodb_app_password     = random_id.mongodb_user_password.hex
  mongodb_root_password    = random_id.mongodb_root_password.hex
  mongodb_database         = var.mongodb_database
  instance_size            = var.mongodb_instance_size
  instance_image           = var.mongodb_instance_image
  instance_data_disk_size  = var.mongodb_instance_data_disk_size
  instance_data_disk_type  = var.mongodb_instance_data_disk_type
  instance_data_disk_name  = "${var.service}-mongo-data-disk"
  instance_network_name    = local.network_name
  instance_tags            = local.mongodb_instance_tags
  instance_labels          = local.mongodb_instance_labels

  dependencies = [
    google_compute_network.vpc_network,
    module.enable-services
  ]
}
