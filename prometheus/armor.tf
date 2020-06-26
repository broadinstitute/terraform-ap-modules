module "broad_internal_access" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/cloud-armor-rule?ref=Cloud-Armor-0.0.1"

  providers = {
    google.target = google.target
  }
}
