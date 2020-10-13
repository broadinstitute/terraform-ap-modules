/**
 * # terra-env module
 *
 * This Terraform module manages resources for a single Terra environment.
 * Each Terra application's resources are defined in its own module that this module references.
 *
 * For more information, check out the [MC-Terra deployment doc](https://docs.dsp-devops.broadinstitute.org/mc-terra/mcterra-deployment)
 * and our [Terraform best practices](https://docs.dsp-devops.broadinstitute.org/best-practices-guides/terraform).
 *
 * This documentation is generated with [terraform-docs](https://github.com/segmentio/terraform-docs)
 * `terraform-docs markdown --no-sort . > README.md`
 */

module "poc_service" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//poc-service?ref=poc-service-0.1.1"

  enable = local.terra_apps["poc"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}

module "identity_concentrator" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//identity-concentrator?ref=identity-concentrator-0.1.1"
  enable = local.terra_apps["identity_concentrator"]

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target      = google.target
    google-beta.target = google-beta.target
  }
}

module "sam" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//sam?ref=sam-0.1.0"

  enable = local.terra_apps["sam"]

  google_project                 = var.google_project
  classic_storage_google_project = local.classic_storage_google_project
  num_admin_sdk_service_accounts = 3
  providers = {
    google.target = google.target
  }
}

module "sam_persistence" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//sam-persistence?ref=sam-persistence-0.1.0"

  enable = local.terra_apps["sam_persistence"]

  google_project = var.google_project
  providers = {
    google.target = google.target
  }
}

module "workspace_manager" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//terra-workspace-manager?ref=terra-workspace-manager-0.3.2"

  enable = local.terra_apps["workspace_manager"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  env_type = var.env_type

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  db_version = var.wsm_db_version
  db_keepers = var.wsm_db_keepers

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}

module "crl_janitor" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//crl-janitor?ref=crl-janitor-0.2.6"

  enable = local.terra_apps["crl_janitor"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  google_folder_id = var.janitor_google_folder_id

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}

module "datarepo" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//datarepo?ref=terra-env-0.3.8"

  enable = local.terra_apps["datarepo"]

  # Create Datarepo DNS records
  # data.<env>.envs-terra.bio
  # OR data.terra.bio for prod
  # gcp global ip names
  datarepo_dns_name   = var.datarepo_dns_name
  grafana_dns_name    = var.grafana_dns_name
  prometheus_dns_name = var.prometheus_dns_name
  # dns zone and project
  dns_zone_name       = var.datarepo_dns_zone_name
  dns_zone_project    = var.datarepo_dns_zone_project
  datarepo_static_ip_name   = var.datarepo_static_ip_name
  grafana_static_ip_name    = var.grafana_static_ip_name
  prometheus_static_ip_name = var.prometheus_static_ip_name

  static_ip_project         = var.datarepo_static_ip_project

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}

module "ontology" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//ontology?ref=ontology-0.1.2"

  enable = local.terra_apps["ontology"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  providers = {
    google.target = google.target
    google.dns    = google.dns
  }
}

module "rbs" {
  //source = "github.com/broadinstitute/terraform-ap-modules.git//rbs?ref=rbs-0.0.2"
  source = "github.com/broadinstitute/terraform-ap-modules.git//rbs?ref=yyu-PF-127"

  enable = local.terra_apps["rbs"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  google_folder_id = var.rbs_google_folder_id

  enable_billing_user = var.rbs_enable_billing_user
  billing_account_id = var.rbs_billing_account_id

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}
