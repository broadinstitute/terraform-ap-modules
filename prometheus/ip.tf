resource "google_compute_address" "ingress_ip" {
  count = var.enable ? 1 : 0

  provider = google.dns

  name = "terra-${local.owner}-${local.service}-ip"
}
