data "google_dns_managed_zone" "dns_zone" {
  provider = google.dns
  project  = var.google_project
  name     = var.dns_zone_name
}

locals {
  fqdn = "${local.hostname}${local.subdomain_name}.${data.google_dns_managed_zone.dns_zone.dns_name}"
}

resource "google_dns_record_set" "ingress" {
  project      = var.google_project
  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = local.fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [google_compute_global_address.ingress_ip[0].address]
}
