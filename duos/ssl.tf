resource "google_compute_managed_ssl_certificate" "duos_cert" {
  count    = var.enable ? 1 : 0
  project  = var.google_project
  provider = google.target
  name     = "terra-${var.cluster}-${local.owner}-${local.service}-managed-cert"

  managed {
    domains = local.managed_domains
  }
}

locals {
  base_managed_domains = [
    local.fqdn,
  ]
  managed_domains = terraform.workspace == "prod" ? concat(base_managed_domains, "duos.broadinstitute.org") : local.base_managed_domains
}
