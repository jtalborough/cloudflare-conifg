# Get DNSSEC status
data "cloudflare_zone_dnssec" "dnssec" {
  zone_id = data.cloudflare_zone.zone.id
}

# Get all zones
data "cloudflare_zones" "all_zones" {
  filter {
    account_id = var.cloudflare_account_id
  }
}

# Output configurations to a file
resource "local_file" "cloudflare_config" {
  filename = "cloudflare_config.json"
  content = jsonencode({
    dnssec_status = data.cloudflare_zone_dnssec.dnssec
    all_zones     = data.cloudflare_zones.all_zones
  })
}

# Output the configurations
output "dnssec_status" {
  value     = data.cloudflare_zone_dnssec.dnssec
  sensitive = true
}

output "all_zones" {
  value     = data.cloudflare_zones.all_zones
  sensitive = true
}
