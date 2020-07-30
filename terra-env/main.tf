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
  source = "github.com/broadinstitute/terraform-ap-modules.git//terra-workspace-manager?ref=terra-workspace-manager-0.3.0"

  enable = local.terra_apps["workspace_manager"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

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
  source = "github.com/broadinstitute/terraform-ap-modules.git//crl-janitor?ref=crl-janitor-0.1.7"

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