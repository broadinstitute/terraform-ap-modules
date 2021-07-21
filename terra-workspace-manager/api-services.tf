module "enable-services" {
  source      = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=services-0.3.0-tf-0.12"
  enable_flag = var.enable && contains(["default", "preview_shared"], var.env_type)
  providers = {
    google.target = google.target
  }
  project = var.google_project
  services = [
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudtrace.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storagetransfer.googleapis.com",
    "bigquerydatatransfer.googleapis.com"
  ]
}
