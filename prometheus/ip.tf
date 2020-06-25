resource "google_compute_address" "ingress_ip" {
  count = var.enable ? 1 : 0

  provider = var.use_subdomain ? google.dns : google.target

  name = "terra-${local.owner}-${local.service}-ip"
}
