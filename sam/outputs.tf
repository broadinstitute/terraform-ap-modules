#
# Service Account Outputs
#
output "app_sa_id" {
  value       = var.enable && contains(["preview_shared"], var.env_type) ? google_service_account.sam[0].account_id : null
  description = "Sam app Google service account ID"
}
output "admin_sdk_sa_ids" {
  value       = var.enable && contains(["preview_shared"], var.env_type) ? google_service_account.sam_admin_sdk.*.account_id : null
  description = "Sam admin SDK Google service account IDs"
}
output "firestore_sa_email" {
  value       = var.enable && contains(["preview_shared"], var.env_type) ? google_service_account.sam-firestore[0].email : null
  description = "Sam Firestore Google service account email"
}

#
# IP/DNS Outputs
#
output "ingress_ip" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_address.ingress_ip[0].address : null
  description = "Sam ingress IP"
}
output "ingress_ip_name" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? google_compute_address.ingress_ip[0].name : null
  description = "Sam ingress IP name"
}
output "fqdn" {
  value       = var.enable && contains(["default", "preview"], var.env_type) ? local.fqdn : null
  description = "Sam fully qualified domain name"
}

#
# Firestore Outputs
#
output "firestore_project_name" {
  value = var.enable && contains(["preview_shared"], var.env_type) ? google_project.sam-firestore[0].name : null
  description = "Sam Firestore project name"
}
