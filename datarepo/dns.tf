data "google_dns_managed_zone" "dns_zone" {
  count = var.enable ? 1 : 0

  provider = google.dns
  name     = var.dns_zone_name
  project  = var.dns_zone_project
}

data "google_compute_global_address" "ingress_ip" {
  count = var.enable ? 1 : 0

  provider = google.target
  name     = var.datarepo_static_ip_name
  project  = var.static_ip_project
}

data "google_compute_global_address" "grafana_ingress_ip" {
  count = var.enable ? 1 : 0

  provider = google.target
  name     = var.grafana_static_ip_name
  project  = var.static_ip_project
}

data "google_compute_global_address" "prometheus_ingress_ip" {
  count = var.enable ? 1 : 0

  provider = google.target
  name     = var.prometheus_static_ip_name
  project  = var.static_ip_project
}

locals {
  datarepo_fqdn = var.enable ? "${var.datarepo_dns_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}" : null
  grafana_fqdn = var.enable ? "${var.grafana_dns_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}" : null
  prometheus_fqdn = var.enable ? "${var.prometheus_dns_name}.${data.google_dns_managed_zone.dns_zone[0].dns_name}" : null
}

# data.alpha.envs-terra.bio
resource "google_dns_record_set" "ingress" {
  count = var.enable ? 1 : 0

  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = local.datarepo_fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [data.google_compute_global_address.ingress_ip[0].address]
  project      = var.dns_zone_project
}

resource "google_dns_record_set" "grafana_ingress" {
  count = var.enable ? 1 : 0

  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = local.grafana_fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [data.google_compute_global_address.grafana_ingress_ip[0].address]
  project      = var.dns_zone_project
}

resource "google_dns_record_set" "prometheus_ingress" {
  count = var.enable ? 1 : 0

  provider     = google.dns
  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = local.prometheus_fqdn
  type         = "A"
  ttl          = "300"
  rrdatas      = [data.google_compute_global_address.prometheus_ingress_ip[0].address]
  project      = var.dns_zone_project
}
