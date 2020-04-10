data "google_dns_managed_zone" "dns_zone" {
  provider = google.dns

  count = var.create_lb ? 1 : 0

  name = var.dns_zone_name
}

# Service DNS
resource "google_dns_record_set" "app_dns" {
  provider = google.dns

  count = var.create_lb ? 1 : 0

  managed_zone = data.google_dns_managed_zone.dns_zone[0].name
  name         = var.lb_dns_name
  type         = "A"
  ttl          = var.lb_dns_ttl
  # module.load-balancer.load_balancer_public_ip is an array
  rrdatas    = module.load-balancer.load_balancer_public_ip
  depends_on = [module.load-balancer, data.google_dns_managed_zone.dns_zone[0]]
}
