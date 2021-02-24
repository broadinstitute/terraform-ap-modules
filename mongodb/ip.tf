resource "google_compute_global_address" "ingress_ip" {
  count = var.expose ? var.replica_count : 0

  provider = google.target

  name = "terra-${var.cluster}-${local.owner}-mongodb-ip-${count.index}"
}
