# Get zone settings
data "cloudflare_zone_dnssec" "dnssec" {
  zone_id = data.cloudflare_zone.zone.id
}

# Get zone details
data "cloudflare_zone" "zone_details" {
  name = "designbuildautomate.io"
}

# Get all zones
data "cloudflare_zones" "all_zones" {
  filter {
    name = "designbuildautomate.io"
  }
}

# Create a local file with the current configuration
resource "local_file" "cloudflare_config" {
  filename = "cloudflare_config.json"
  content = jsonencode({
    zone_details  = data.cloudflare_zone.zone_details
    dnssec_status = data.cloudflare_zone_dnssec.dnssec
    all_zones     = data.cloudflare_zones.all_zones
  })
}

# Output the configurations
output "zone_details" {
  value     = data.cloudflare_zone.zone_details
  sensitive = true
}

output "dnssec_status" {
  value     = data.cloudflare_zone_dnssec.dnssec
  sensitive = true
}

output "all_zones" {
  value     = data.cloudflare_zones.all_zones
  sensitive = true
}
