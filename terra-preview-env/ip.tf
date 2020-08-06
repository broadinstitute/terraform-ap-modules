resource "google_compute_address" "ingress" {
  for_each = toset(var.services)

  provider = google.target

  name = "terra-${var.cluster}-${local.owner}-${each.key}"
}
