resource "google_compute_network" "k8s-cluster-network" {
  provider                = google-beta.target
  project                 = var.google_project
  name                    = local.cluster_network
  auto_create_subnetworks = true
  depends_on              = [module.enable-services]
}
