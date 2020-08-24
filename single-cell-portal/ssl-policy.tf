resource "google_compute_ssl_policy" "policy" {
  name            = local.ssl_policy_name
  profile         = "RESTRICTED"
  min_tls_version = "TLS_1_2"
}
