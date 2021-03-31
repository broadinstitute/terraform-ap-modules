module "enable-services" {
  source      = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=services-0.3.0-tf-0.12"
  enable_flag = "1"
  providers = {
    google.target = google.target
  }
  project = google_project.project.name
  services = [
    # APIs exercised by Janitor integration testing.
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "bigquery.googleapis.com",
    "notebooks.googleapis.com",
  ]
}
