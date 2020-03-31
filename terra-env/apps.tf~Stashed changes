module "poc_service" {
  source  = "github.com/broadinstitute/terraform-ap-modules.git//poc-service?ref=poc-service-0.0.0"

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target = google.target
    google-beta.target = google-beta.target
  }
}

module "identity_concentrator" {
  source  = "github.com/broadinstitute/terraform-ap-modules.git//identity-concentrator?ref=identity-concentrator-0.0.0"

  google_project = var.google_project
  cluster        = var.cluster

  providers = {
    google.target = google.target
    google-beta.target = google-beta.target
  }
}
