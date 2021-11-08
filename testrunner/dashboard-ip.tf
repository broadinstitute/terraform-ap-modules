resource "google_compute_global_address" "ingress_ip" {
  count       = var.enable_dashboard && contains(["default", "preview"], var.env_type) ? 1 : 0
  provider    = google.target
  name        = "${local.owner}-${local.dashboardservice}-ip"
  description = "The ingress IP of TestRunner Dashboard"
}
