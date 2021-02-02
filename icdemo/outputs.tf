#
# Service Account Outputs
#

output "app_sa_id" {
  value       = var.enable ? google_service_account.app[0].account_id : null
  description = "Identity Concentrator Google service accout ID"
}
