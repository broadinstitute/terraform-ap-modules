data "google_dns_managed_zone" "dns_zone" {
  provider = google.dns
  name     = var.dns_zone_name
}

locals {
  fqdn = var.enable ? "${local.hostname}${local.subdomain_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}" : null
}

resource "google_dns_record_set" "ingress" {
  for_each = toset(var.services)

  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  name         = local.fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [google_compute_address.ingress_ip[each.key].address]
}
