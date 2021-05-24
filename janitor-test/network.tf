# Create a VPC network for testing AI Notebooks, which require a network.
resource "google_compute_network" "vpc_network" {
  name = "default"
  auto_create_subnetworks = true
  project = google_project.project.project_id
}
