resource "google_compute_address" "ingress_ip" {
  count = var.enable && ! var.preview ? 1 : 0

  provider = google.target

  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip"
}
