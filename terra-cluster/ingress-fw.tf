#
# Create a CloudArmor policy for private Terra ingresses.
#
locals {
  # Make sure Cloud NAT egress addresses are whitelisted in the Ingress firewall,
  # so that traffic originating from within the cluster can pass through the Ingress
  cluster_egress_cidrs  = google_compute_address.nat-address.*.address
  private_ingress_cidrs = concat(var.private_ingress_cidrs, local.cluster_egress_cidrs)
}
resource "google_compute_security_policy" "terra-private-ingress-policy" {
  name = "${module.k8s-master.name}-private-ingress-policy"

  # Chunk all cidrs into groups of 5 (max allowed in a rule),
  # add add a whitelist rule for each chunk
  dynamic "rule" {
    for_each = chunklist(local.private_ingress_cidrs, 5)

    content {
      action   = "allow"
      priority = rule.key # priority matches index in list

      match {
        versioned_expr = "SRC_IPS_V1"

        config {
          src_ip_ranges = rule.value
        }
      }
    }
  }

  rule {
    action      = "allow"
    priority    = size(var.private_ingress_cidrs)
    description = "Allow traffic originating from within the cluster"

    match {}
  }

  rule {
    action      = "deny(403)"
    priority    = "2147483647"
    description = "Default rule: deny all"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}
