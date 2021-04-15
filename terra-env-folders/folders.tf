resource "google_folder" "env_projects_folder" {
  display_name = "terr-projects-${terraform.workspace}"
  parent       = var.parent_container
  provider     = google.target
}
