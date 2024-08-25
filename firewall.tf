resource "google_compute_firewall" "iap-access" {
  name    = local.firewall_config.name
  network = local.firewall_config.network

  allow {
    protocol = local.firewall_config.allowed_protocol
  }

  source_ranges = [local.firewall_config.source_range]
  target_tags   = local.firewall_config.target_tags
}