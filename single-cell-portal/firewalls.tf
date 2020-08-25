# firewall rules for only allowing access from company internal CIDRs

resource "google_compute_firewall" "allow_http_vpn" {
  provider = google-beta.target

  dynamic "log_config" {
    for_each = var.enable_logging ? [ 1 ] : []
    content {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }

  name           = "allow-http-internal"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.corp_range_cidrs
  target_tags   = ["http-server"]

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "allow_https_vpn" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "allow-https-internal"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = var.corp_range_cidrs
  target_tags   = ["http-server"]

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "allow_ssh_vpn" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "allow-ssh-internal"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.corp_range_cidrs

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "allow_mongo_vpn" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "allow-mongo-internal"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_ranges = var.corp_range_cidrs
  target_tags   = ["mongodb"]

  depends_on = [google_compute_network.vpc_network]
}


# Firewall rules for allowing services to talk to each other

resource "google_compute_firewall" "managed_allow_mongo_client" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "managed-allow-mongo-client"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_ranges = split(",", var.internal_range)
  target_tags   = ["mongodb"]

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "managed_allow_https" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "managed-allow-https"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = split(",", var.internal_range)
  target_tags   = ["https-server"]

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "managed_allow_http" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "managed-allow-http"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = split(",", var.internal_range)
  target_tags   = ["http-server"]

  depends_on = [google_compute_network.vpc_network]
}


# Firewall rules for CI - Jenkins

resource "google_compute_firewall" "ci_ssh" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "ci-ssh"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ci_range_cidrs

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "ci_https" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "ci-https"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = var.ci_range_cidrs
  target_tags   = ["https-server"]

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "ci_http" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "ci-http"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.ci_range_cidrs
  target_tags   = ["http-server"]

  depends_on = [google_compute_network.vpc_network]
}


# Firewall rules for CI - Travis
data "http" "travis_ips" {
  url = "https://dnsjson.com/nat.travisci.net/A.json"
}
locals {
  travis_ips = formatlist("%s/32", jsondecode(data.http.travis_ips.body)["results"]["records"])
}
resource "google_compute_firewall" "mongo_from_travis" {
  provider = google-beta.target

  count = var.allow_travis ? 1 : 0

  enable_logging = var.enable_logging
  name           = "travis-mongo"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_ranges = local.travis_ips
  target_tags   = ["mongodb"]

  depends_on = [google_compute_network.vpc_network]
}


# Firewall rules for health checks

resource "google_compute_firewall" "health_https" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "health-https"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = var.gcp_health_check_range_cidrs
  target_tags   = ["https-server"]

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_firewall" "health_http" {
  provider = google-beta.target

  enable_logging = var.enable_logging
  name           = "health-http"
  network        = local.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.gcp_health_check_range_cidrs
  target_tags   = ["http-server"]

  depends_on = [google_compute_network.vpc_network]
}
