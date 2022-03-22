
resource "google_service_account" "billing-probe" {
  count        = var.enable ? 1 : 0
  provider     = google.target
  project      = var.google_project
  account_id   = "billing-probe"
  display_name = "Terra Billing Probe"
  description  = "Probe to check that users have given Terra the correct privileges on their Billing Accounts to create projects."
}

resource "google_service_account_iam_member" "billing-probe-sa-token-creator" {
  count              = var.enable ? 1 : 0
  service_account_id = google_service_account.billing-probe[0].name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${var.service_accounts.rawls}"
}
