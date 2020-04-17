resource "google_compute_network" "vpc_network" {
  provider = google-beta.target

  count                   = var.create_network ? 1 : 0
  project                 = var.google_project
  name                    = local.network_name
  auto_create_subnetworks = true
  depends_on              = [module.enable-services]
}
