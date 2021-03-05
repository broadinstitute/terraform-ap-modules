resource "google_compute_address" "ingress_ip" {
  provider = google.target
  project  = var.google_project

  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip"
}

resource "google_compute_address" "expose_ips" {
  count    = var.expose ? var.replica_count : 0
  provider = google.target
  project  = var.google_project

  name = "terra-${var.cluster}-${local.owner}-${local.service}-ip-${count.index}"
}
