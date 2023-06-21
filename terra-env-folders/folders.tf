resource "google_folder" "terra_root_folder" {
  display_name = var.folder_display_name
  parent       = var.parent_container
  provider     = google.target
}
