module "enable-services" {
  source      = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=services-0.3.0-tf-0.12"
  enable_flag = "1"
  providers = {
    google.target = google.target
  }
  project = var.google_project
  services = [
    "cloudbilling.googleapis.com",
  ]
}
