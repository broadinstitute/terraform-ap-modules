resource "google_compute_address" "ingress" {
  for_each = var.terra_apps

  provider = google.target

  name = "terra-${var.cluster}-${local.owner}-${each.key}"
}
