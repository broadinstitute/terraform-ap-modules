data "google_dns_managed_zone" "dns_zone" {
  provider = google.dns
  name     = var.dns_zone_name
}

locals {
  fqdns = {
    for app in keys(var.terra_apps):
    app => "${var.terra_apps[app]}.${local.subdomain_name}.preview.${data.google_dns_managed_zone.dns_zone.dns_name}"
  }
}

resource "google_dns_record_set" "ingress" {
  for_each = var.terra_apps

  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  name         = fqdns[each.key]
  type         = "A"
  ttl          = "300"
  rrdatas      = [google_compute_address.ingress_ip[each.key].address]
}
