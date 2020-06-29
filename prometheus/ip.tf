resource "google_compute_global_address" "ingress_ip" {
  count = var.enable ? 1 : 0

  provider = google.dns
  project  = local.project

  name = "terra-${local.owner}-${local.service}-ip"
}
