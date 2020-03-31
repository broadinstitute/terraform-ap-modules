# Create a NAT router for k8s so nodes can interact with external services as a static IP.

resource "google_compute_router" "router" {
  name = "${var.service}-${local.owner}"
  project = var.google_project
  network = google_compute_network.k8s-cluster-network.self_link

  bgp {
    asn = 64515
  }
}

resource "google_compute_address" "nat-address" {
  count = 2
  name = "${var.service}-${local.owner}-${count.index}"
  project = var.google_project
  depends_on = [module.enable-services]
}

resource "google_compute_router_nat" "nat" {
  name = "${var.service}-${local.owner}"
  project = var.google_project
  router = google_compute_router.router.name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = google_compute_address.nat-address[*].self_link

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
