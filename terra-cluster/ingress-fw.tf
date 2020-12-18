#
# Create a CloudArmor policy for private Terra ingresses.
#
locals {
  # Make sure Cloud NAT egress addresses are whitelisted in the Ingress firewall,
  # so that traffic originating from within the cluster can still pass through the Ingress
  cluster_egress_addresses = [{
    description = "${module.k8s-master.name} cluster egress IPs"
    addresses   = google_compute_address.nat-address.*.address
  }]

  private_ingress_whitelist = concat(local.cluster_egress_addresses, var.private_ingress_whitelist)

  # A maximum of 5 addresses are permitted in each CloudArmor firewall rule,
  # so divide up any address lists with > 5 into multiple rules
  chunked_whitelist = flatten([
    for whitelist in local.private_ingress_whitelist : [
      for chunk in chunklist(whitelist.addresses, 5) : {
        description = whitelist.description
        addresses   = chunk
      }
    ]
  ])
}

resource "google_compute_security_policy" "terra-private-ingress-policy" {
  name = "${module.k8s-master.name}-private-ingress-policy"

  # Chunk all cidrs into groups of 5 (max allowed in a rule),
  # add add a whitelist rule for each chunk
  dynamic "rule" {
    for_each = local.chunked_whitelist

    content {
      action   = "allow"
      priority = rule.key # set priority to index in list

      description = rule.value.description

      match {
        versioned_expr = "SRC_IPS_V1"

        config {
          src_ip_ranges = rule.value.addresses
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
