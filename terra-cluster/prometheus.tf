module "prometheus" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//prometheus?ref=terra-cluster-0.0.14"

  enable         = true
  environment    = local.owner
  google_project = var.google_project

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  providers = {
    google.dns    = google.dns
    google.target = google.target
  }
}
