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
  managed_domains = concat(local.base_managed_domains, var.additional_managed_domains)
}

# For Google managed certs to work properly we also need a CAA record that authorizes the 
# letsencrypt.org and pki issuers to issue a TLS cert for duos

resource "google_dns_record_set" "duos_caa" {
  count        = var.enable ? 1 : 0
  project      = var.google_project
  provider     = google.target
  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = local.fqdn
  type         = "CAA"
  ttl          = "300"
  rrdatas      = var.authorized_certificate_authorities
}
