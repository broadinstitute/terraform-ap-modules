resource "google_service_account" "prometheus" {
  project      = var.google_project
  account_id   = "prometheus"
  display_name = "prometheus"
  provider     = google.target
}

locals {
  roles = [
    "roles/monitoring.metricWriter",
  ]
}

resource "google_project_iam_member" "prometheus_iam" {
  for_each = toset(local.roles)
  project  = var.google_project
  role     = each.key
  member   = "serviceAccount:${google_service_account.prometheus.email}"
  provider = google.target
}

# Workload Identity User policy (project config)
data "google_iam_policy" "prometheus_workload_identity_policy" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      "serviceAccount:${var.google_project}.svc.id.goog[${var.k8s_namespace}/terra-prometheus-operator-prometheus]",
      "serviceAccount:${var.google_project}.svc.id.goog[${var.k8s_namespace}/prometheus-to-sd-sa]",
  }
  provider = google.target
}

# Workload Identity User policy (SA config)
resource "google_service_account_iam_policy" "prometheus-dns_workload_identity_iam" {
  service_account_id = google_service_account.sherlock.name
  policy_data        = data.google_iam_policy.sherlock_workload_identity_policy.policy_data
  provider           = google.target
}
