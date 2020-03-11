# firewall rules for only allowing access from company internal CIDRs

resource "google_compute_firewall" "allow_http_vpn" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "allow-http-internal"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "80" ]
  }

  source_ranges = var.corp_range_cidrs
  target_tags = [ "http-server" ]

  depends_on = [ google_compute_network.vpc_network ]
}

resource "google_compute_firewall" "allow_https_vpn" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "allow-https-internal"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "443" ]
  }

  source_ranges = var.corp_range_cidrs
  target_tags = [ "http-server" ]

  depends_on = [ google_compute_network.vpc_network ]
}

resource "google_compute_firewall" "allow_ssh_vpn" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "allow-ssh-internal"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "22" ]
  }

  source_ranges = var.corp_range_cidrs

  depends_on = [ google_compute_network.vpc_network ]
}

resource "google_compute_firewall" "allow_mongo_vpn" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "allow-mongo-internal"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "27017" ]
  }

  source_ranges = var.corp_range_cidrs
  target_tags = [ "mongodb" ]

  depends_on = [ google_compute_network.vpc_network ]
}


# Firewall rules for allowing services to talk to each other

resource "google_compute_firewall" "managed_allow_mongo_client" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "managed-allow-mongo-client"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "27017"]
  }

  source_ranges = split(",", var.internal_range)
  target_tags = [ "mongodb" ]

  depends_on = [ google_compute_network.vpc_network ]
}

resource "google_compute_firewall" "managed_allow_https" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "managed-allow-https"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "443"]
  }

  source_ranges = split(",", var.internal_range)
  target_tags = [ "https-server" ]

  depends_on = [ google_compute_network.vpc_network ]
}

resource "google_compute_firewall" "managed_allow_http" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "managed-allow-http"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "80"]
  }

  source_ranges = split(",", var.internal_range)
  target_tags = [ "http-server" ]

  depends_on = [ google_compute_network.vpc_network ]
}


# Firewall rules for CI

resource "google_compute_firewall" "ci_ssh" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "ci-ssh"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "22" ]
  }

  source_ranges = var.ci_range_cidrs

  depends_on = [ google_compute_network.vpc_network ]
}

resource "google_compute_firewall" "ci_https" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "ci-https"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "443" ]
  }

  source_ranges = var.ci_range_cidrs
  target_tags = [ "https-server" ]

  depends_on = [ google_compute_network.vpc_network ]
}

resource "google_compute_firewall" "ci_http" {
  provider = google-beta.target
  enable_logging = var.enable_logging
  name = "ci-http"
  network = local.network_name

  allow {
    protocol = "tcp"
    ports = [ "80" ]
  }

  source_ranges = var.ci_range_cidrs
  target_tags = [ "http-server" ]

  depends_on = [ google_compute_network.vpc_network ]
}
