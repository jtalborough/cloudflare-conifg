# Get DNS records for the zone
data "cloudflare_zones" "dns_zone" {
  filter {
    name = "designbuildautomate.io"
  }
}

# Get zone settings
resource "cloudflare_zone_settings_override" "settings" {
  zone_id = data.cloudflare_zones.dns_zone.zones[0].id
  settings {
    ssl = "full"
    always_use_https = "on"
  }
}

# Export the current state
resource "local_file" "full_cloudflare_config" {
  filename = "full_cloudflare_config.json"
  content = jsonencode({
    zone_details = {
      id = data.cloudflare_zones.dns_zone.zones[0].id
      name = "designbuildautomate.io"
      settings = cloudflare_zone_settings_override.settings
    }
  })
}

# Output zone settings
output "zone_settings" {
  value     = cloudflare_zone_settings_override.settings
  sensitive = true
}
