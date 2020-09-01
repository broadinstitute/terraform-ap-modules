# Folder used to contain projects created in CRL integration tests.
# We create a separate folder to scope the CRL test SA broad folder permissions to a single purpose folder.
resource "google_folder" "test_resource_container" {
  display_name = "CRL Test resource container"
  parent = var.folder_id

  provider = google.target
}
