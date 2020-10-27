# Folder used to contain projects created by WM.
# We create a separate folder to scope the WM SA broad folder permissions to a single purpose folder.
# TODO(PF-156): Once WM uses RBS, we no longer need permissions to create projects, or this folder.
resource "google_folder" "workspace_project_folder" {
  count        = var.enable && contains(["default", "preview_shared"], var.env_type) && var.workspace_project_folder_id != null ? 1 : 0
  display_name = "${local.service}-${local.owner} workspace project folder"
  parent       = "folders/${var.workspace_project_folder_id}"
  provider     = google.target
}
