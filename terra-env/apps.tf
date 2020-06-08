module "poc_service" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//poc-service?ref=gm-ip-dns"

  enable = local.terra_apps["poc"]

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target      = google.target
    google.dns         = google.dns
    google-beta.target = google-beta.target
  }
}

module "identity_concentrator" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//identity-concentrator?ref=identity-concentrator-0.1.0"

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
  classic_storage_google_project = var.classic_storage_google_project
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
  source = "github.com/broadinstitute/terraform-ap-modules.git//terra-workspace-manager?ref=gm-ip-dns"

  enable = local.terra_apps["workspace_manager"]

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target      = google.target
    google-beta.target = google-beta.target
  }
}
