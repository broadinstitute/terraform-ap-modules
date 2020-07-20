resource "google_compute_global_address" "ingress_ip" {
  count = var.enable ? 1 : 0

  provider = google.target
  project  = var.google_project

  name = "terra-${local.owner}-${local.service}-ip"
}
