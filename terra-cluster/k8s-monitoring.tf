module "cluster_monitoring" {
  source = "github.com/broadinstitute/terraform-shared.git//terraform-modules/stackdriver/k8s-cluster-monitoring?ref=k8s-cluster-monitoring-0.0.3-tf-0.12"
  providers = {
    google.target = google.target
  }
  project               = var.google_project
  notification_channels = var.notification_channels
}
