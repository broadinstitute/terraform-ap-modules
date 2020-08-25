#
# IP/DNS Outputs
#
output "ingress_ips" {
  value       = {
    for service, ip in google_compute_address.ingress :
    service => ip.address
  }
  description = "Service ingress IPs"
}
output "fqdns" {
  value       = local.fqdns
  description = "Service fully qualified domain names"
}
output "versions" {
  value       = var.versions
  description = "Base64 encoded JSON string of version overrides"
}