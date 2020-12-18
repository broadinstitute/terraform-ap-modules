locals {
  create_folder = var.enable && contains(["default", "preview_shared"], var.env_type) && var.workspace_project_folder_id != ""
}
# Folder used to contain projects created by Buffer Service, then we tell Buffer Service to use this folder to create
# project within.
resource "google_folder" "workspace_project_folder" {
  count        = local.create_folder ? 1 : 0
  display_name = "${local.service}-${local.owner} projects"
  parent       = "folders/${var.workspace_project_folder_id}"
  provider     = google.target
}
