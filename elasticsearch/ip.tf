resource "google_compute_address" "ingress_ip" {
  provider = google.target
  project  = var.google_project

  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip"
}

