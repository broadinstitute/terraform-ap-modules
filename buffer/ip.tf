resource "google_compute_address" "ingress_ip" {
  count = var.enable && !var.global_ip ? 1 : 0

  provider = google.target

  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip"
}

resource "google_compute_global_address" "ingress_ip" {
  count = var.enable && var.global_ip ? 1 : 0

  provider = google.target

  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip"
}

locals {
  ingress_ip = var.global_ip ? [google_compute_global_address.ingress_ip[0].address] : [google_compute_address.ingress_ip[0].address]
  ingress_ip_name = var.global_ip ? [google_compute_global_address.ingress_ip[0].name] : [google_compute_address.ingress_ip[0].name]
}
