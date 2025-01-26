data "cloudflare_zone" "zone" {
  name = "designbuildautomate.io"
}

# This will be used as a reference for other resources
output "zone_id" {
  value = data.cloudflare_zone.zone.id
}
