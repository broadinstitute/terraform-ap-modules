resource "google_compute_address" "ingress_ip" {
  provider = google.target
  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip"
}
