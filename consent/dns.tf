data "google_dns_managed_zone" "dns_zone" {
  count    = var.enable ? 1 : 0
  provider = google.dns

  name = var.dns_zone_name
}

locals {
  fqdn = var.enable ? "${local.hostname}${local.subdomain_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}" : null
}

resource "google_dns_record_set" "ingress" {
  count = var.enable ? 1 : 0

  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = local.fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [google_compute_global_address.ingress_ip[0].address]
}
