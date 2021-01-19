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
  source = "github.com/broadinstitute/terraform-ap-modules.git//poc-service?ref=poc-service-0.1.2"

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
  source = "github.com/broadinstitute/terraform-ap-modules.git//identity-concentrator?ref=identity-concentrator-0.1.2"
  enable = local.terra_apps["identity_concentrator"]

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target      = google.target
    google-beta.target = google-beta.target
  }
}

module "sam" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//sam?ref=sam-0.3.0"
  enable = local.terra_apps["sam"]

  providers = {
    google.target = google.target
    google.dns    = google.dns
  }

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  env_type = var.env_type

  hostname       = var.sam_hostname
  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  num_admin_sdk_service_accounts = var.sam_sdk_sa_count

  firestore_project_name       = var.sam_firestore_project_name
  firestore_billing_account_id = var.sam_firestore_billing_account_id
  firestore_folder_id          = var.sam_firestore_folder_id
}

module "workspace_manager" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//terra-workspace-manager?ref=terra-workspace-manager-0.5.1"

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

  workspace_project_folder_id = var.wsm_workspace_project_folder_id
  billing_account_ids         = var.wsm_billing_account_ids
  workspace_project_folder_ids = local.wsm_folder_ids

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}

module "crl_janitor" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//crl-janitor?ref=crl-janitor-0.2.8"

  enable = local.terra_apps["crl_janitor"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  google_folder_ids = var.janitor_google_folder_ids

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
  dns_zone_name             = var.datarepo_dns_zone_name
  dns_zone_project          = var.datarepo_dns_zone_project
  datarepo_static_ip_name   = var.datarepo_static_ip_name
  grafana_static_ip_name    = var.grafana_static_ip_name
  prometheus_static_ip_name = var.prometheus_static_ip_name

  static_ip_project = var.datarepo_static_ip_project

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

module "buffer" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//buffer?ref=buffer-0.2.1"

  enable = local.terra_apps["buffer"]

  google_project = var.google_project
  cluster        = var.cluster
  cluster_short  = var.cluster_short

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  global_ip = var.buffer_global_ip

  db_version = var.buffer_db_version
  db_keepers = var.buffer_db_keepers

  external_folder_ids = var.buffer_external_folder_ids
  root_folder_id = var.buffer_root_folder_id
  pool_names = var.buffer_pool_names

  billing_account_ids = var.buffer_billing_account_ids

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}

module "consent" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//consent?ref=consent-0.2.0"

  enable = local.terra_apps["consent"]

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

module "rawls" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//rawls?ref=rawls-0.1.0"

  enable = local.terra_apps["rawls"]

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

module "leonardo" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//leonardo?ref=leonardo-0.0.1"

  enable = local.terra_apps["leonardo"]

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

module "agora" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//agora?ref=agora-0.1.0"

  enable = local.terra_apps["agora"]

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

module "firecloudorch" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//firecloudorch?ref=firecloudorch-0.1.0"

  enable = local.terra_apps["firecloudorch"]

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
