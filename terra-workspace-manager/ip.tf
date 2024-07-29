resource "google_compute_global_address" "ingress_ip" {
  count = var.enable && var.dns_enabled && contains(["default", "preview"], var.env_type) ? 1 : 0

  provider = google.target

  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip"
}
