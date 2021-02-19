# Create a NAT router for k8s so nodes can interact with external services as a static IP.

resource "google_compute_router" "router" {
  count   = var.create_nat_gateway ? 1 : 0
  name    = local.names.router
  project = var.google_project
  network = local.cluster_network_self_link

  bgp {
    asn = 64515
  }
}

resource "google_compute_address" "nat-address" {
  count      = var.create_nat_gateway ? var.nat_egress_ip_count : 0
  name       = "${local.names.nat}-${count.index}"
  project    = var.google_project
  depends_on = [module.enable-services]
}

resource "google_compute_router_nat" "nat" {
  count   = var.create_nat_gateway ? 1 : 0
  name    = local.names.nat
  project = var.google_project
  router  = google_compute_router.router[0].name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.nat-address[*].self_link

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  min_ports_per_vm                    = var.cloud_nat_settings.min_ports_per_vm
  enable_endpoint_independent_mapping = var.cloud_nat_settings.enable_endpoint_independent_mapping
  tcp_established_idle_timeout_sec    = var.cloud_nat_settings.tcp_established_idle_timeout_sec

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
