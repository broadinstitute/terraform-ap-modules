#
# Create a CloudArmor policy for private Terra ingresses.
#
resource "google_compute_security_policy" "terra-private-ingress-policy" {
  name = "${module.k8s-master.name}-private-ingress-policy"

  # Chunk all cidrs into groups of 5 (max allowed in a rule),
  # add add a whitelist rule for each chunk
  dynamic "rule" {
    for_each = chunklist(var.private_ingress_cidrs, 5)

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
