resource "google_compute_network" "vpc_network" {          
  count        = var.create_network ? 1 : 0
  provider     = google-beta.target
  project      = var.google_project
  name         = local.network_name
  auto_create_subnetworks = true
  depends_on = [ module.enable-services ]
}
