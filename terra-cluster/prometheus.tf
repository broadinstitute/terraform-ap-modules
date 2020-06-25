module "prometheus" {
  source = "github.com/broadinstitute/terraform-ap-modules.git//prometheus?ref=DDO-337-prometheus-ingress"

  environment = local.owner

  providers = {
    google.dns = google.dns
  }
}
