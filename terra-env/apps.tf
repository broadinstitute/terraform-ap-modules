module "poc_service" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//poc-service?ref=poc-service-0.0.0"

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target      = google.target
    google-beta.target = google-beta.target
  }
}

module "identity_concentrator" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//identity-concentrator?ref=identity-concentrator-0.0.0"

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target      = google.target
    google-beta.target = google-beta.target
  }
}

module "sam" {
  source  = "github.com/broadinstitute/terraform-ap-modules.git//sam?ref=sam-0.0.1"
  google_project = var.google_project
  classic_storage_google_project = var.classic_storage_google_project
  num_admin_sdk_service_accounts = 3
}

module "workspace_manager" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//terra-workspace-manager?ref=terra-workspace-manager-0.0.0"

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target      = google.target
    google-beta.target = google-beta.target
  }
}
