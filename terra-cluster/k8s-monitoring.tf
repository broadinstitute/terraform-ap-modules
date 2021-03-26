module "cluster_monitoring" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/stackdriver/k8s-cluster-monitoring?ref=stackdriver-0.2.3"
  providers = {
    google.target = google.target
  }
  # Work around for legacy gcp projects being monitored from a common external stackdriver workspac
  project               = var.use_legacy_stackdriver_workspace ? var.stackdriver_workspace_project : var.google_project
  notification_channels = var.notification_channels
}
