resource "google_kms_key_ring" "keyring" {
  name     = var.kms_keyring
  location = "us-central1"
  project = var.google_project
}

resource "google_kms_crypto_key" "ssh_keypair_encryption_key" {
  name            = var.ssh_keypair_encryption_kms_key
  key_ring        = google_kms_key_ring.keyring.id

  lifecycle {
    prevent_destroy = true
  }
}