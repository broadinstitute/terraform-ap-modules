module "crl-project" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/google-project?ref=google-project-0.0.3-tf-0.12"

  project_name = var.google_project
  folder_id = var.folder_id
  billing_account_id = var.billing_account_id
  apis_to_enable = [
    # APIs needed by CRL functionality.
    "cloudtrace.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    # APIs exercised by CRL integration testing.
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
  ]

  providers = {
    google.target = google.target
  }
}