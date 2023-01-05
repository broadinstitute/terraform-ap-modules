# Google project for Sam Firestore
resource "google_project" "sam-firestore" {
  count = var.enable && contains(["preview_shared"], var.env_type) ? 1 : 0

  provider = google.target

  name                = local.firestore_project_name
  project_id          = local.firestore_project_name
  billing_account     = var.firestore_billing_account_id
  folder_id           = var.firestore_folder_id
  auto_create_network = false
}

module "enable-services-firestore" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/api-services?ref=gm-api-project"

  enable_flag = var.enable && contains(["preview_shared"], var.env_type)

  providers = {
    google.target = google.target
  }
  google_project = var.enable && contains(["preview_shared"], var.env_type) ? google_project.sam-firestore[0].name : ""
  services = [
    "cloudfunctions.googleapis.com",
    "firestore.googleapis.com"
  ]
}


