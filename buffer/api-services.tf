module "enable-services" {
  source      = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=services-0.3.0-tf-0.12"
  enable_flag = var.enable ? "1" : "0"
  providers = {
    google.target = google.target
  }
  project = var.google_project
  services = [
    "cloudbilling.googleapis.com",
  ]
}
