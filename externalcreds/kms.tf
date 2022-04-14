resource "google_kms_key_ring" "keyring" {
  name     = "ssh-keypair-encryption-keyring"
  location = "global"
  project = var.google_project
}

resource "google_kms_crypto_key" "ssh-keypair-encryption-key" {
  name            = "ssh-keypair-encryption-key"
  key_ring        = google_kms_key_ring.keyring.id

  lifecycle {
    prevent_destroy = true
  }
}