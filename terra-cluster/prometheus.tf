module "prometheus" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//prometheus?ref=DDO-337-prometheus-ingress"

  enable      = true
  environment = local.owner

  dns_zone_name  = var.dns_zone_name
  subdomain_name = var.subdomain_name
  use_subdomain  = var.use_subdomain

  providers = {
    google.dns = var.use_subdomain ? google.dns : google.target
  }
}