data "google_dns_managed_zone" "dns_zone" {
  count = var.enable ? 1 : 0

  provider = google.dns
  name     = var.dns_zone_name
  project  = var.dns_zone_project
}

data "google_compute_global_address" "ingress_ip" {
  count = var.enable ? 1 : 0

  provider = google.target
  name     = var.static_ip_name
  project  = var.static_ip_project
}

locals {
  fqdn = var.enable ? "${var.dns_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}" : null
}

# data.alpha.envs-terra.bio
resource "google_dns_record_set" "ingress" {
  count = var.enable ? 1 : 0

  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = local.fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [data.google_compute_global_address.ingress_ip[0].address]
  project      = var.dns_zone_project
}
