resource "google_kms_key_ring" "keyring" {
  name     = var.ssh_keypair_encryption_kms_keyring
  location = "global"
  project = var.google_project
}

resource "google_kms_crypto_key" "ssh-keypair-encryption-key" {
  name            = var.ssh_keypair_encryption_kms_key
  key_ring        = google_kms_key_ring.keyring.id

  lifecycle {
    prevent_destroy = true
  }
}