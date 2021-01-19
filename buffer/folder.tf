locals {
  create_folders = var.enable && var.root_folder_id != ""
}

# Create a single folder under the passed in root folder. This folder will hold the pool-specific folders.
resource "google_folder" "pool_parent_folder" {
  count        = local.create_folders ? 1 : 0
  display_name = "${local.service}-${local.owner}"
  parent       = "folders/${var.root_folder_id}"
  provider     = google.target
}

# Create one folder for each pool to hold all projects created from that pool
resource "google_folder" "pool_folders" {
  for_each     = local.create_folders ? toset(var.pool_names) : []
  display_name = each.key
  // If create_folders is false, none of these will be generated. If it is true, there will be exactly one
  // pool_parent_folder.
  parent       = local.create_folders ? google_folder.pool_parent_folder[0].name : ""
  provider     = google.target
}
