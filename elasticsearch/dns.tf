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
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  name         = local.fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [google_compute_address.ingress_ip.address]
}

# create dns records for expose ips in the v5.6 test cluster
resource "google_dns_record_set" "es_56_expose" {
  count        = var.enable_56 ? var.replica_count : 0
  project      = var.google_project
  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  name         = "${local.hostname}-${count.index}${local.subdomain_name}.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type         = "A"
  ttl          = "300"
  rrdatas      = [google_compute_address.expose_ips[count.index].address]
}
