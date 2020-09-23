module "enable-services" {
  source      = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=services-0.3.0-tf-0.12"
  enable_flag = "1"
  providers = {
    google.target = google.target
  }
  project = google_project.project.name
  services = [
    # APIs needed by CRL functionality.
    "cloudtrace.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    # APIs exercised by CRL integration testing.
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "bigquery.googleapis.com",
    "cloudbilling.googleapis.com",
  ]
}
