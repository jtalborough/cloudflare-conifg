# Get DNS records for the zone
data "cloudflare_zones" "dns_zone" {
  filter {
    name = "designbuildautomate.io"
  }
}

data "cloudflare_zone" "zone" {
  name = "designbuildautomate.io"
}

data "cloudflare_zone" "zone_details" {
  name = "designbuildautomate.io"
}

# Get zone settings
resource "cloudflare_zone_settings_override" "settings" {
  zone_id = data.cloudflare_zones.dns_zone.zones[0].id
  settings {
    ssl = "full"
    always_use_https = "on"
  }
}

# A Records
resource "cloudflare_record" "root" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "@"
  type            = "A"
  content         = "62.146.224.217"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "www" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "www"
  type            = "A"
  content         = "62.146.224.217"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "homegrown" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "homegrown"
  type            = "A"
  content         = "62.146.224.217"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "n8n" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "n8n"
  type            = "A"
  content         = "62.146.224.217"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "portainer" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "portainer"
  type            = "A"
  content         = "62.146.224.217"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "barcall" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "barcall"
  type            = "A"
  content         = "192.0.2.1"  # Placeholder IP for redirect
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

# CNAME Records
resource "cloudflare_record" "automateeverything" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "automateeverything"
  type            = "CNAME"
  content         = "98c9fe3a-dd79-4d83-89fe-bdd26f7847e5.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "chat" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "chat"
  type            = "CNAME"
  content         = "a6526d8d-adfe-4761-a7fb-bcc6bd7c2c85.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "lab_n8n" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "lab-n8n"
  type            = "CNAME"
  content         = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "lab_nextcloud" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "lab-nextcloud"
  type            = "CNAME"
  content         = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "lab_portainer" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "lab-portainer"
  type            = "CNAME"
  content         = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "lab_rancher" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "lab-rancher"
  type            = "CNAME"
  content         = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "lab_vc4" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "lab-vc4"
  type            = "CNAME"
  content         = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "mail" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "mail"
  type            = "CNAME"
  content         = "mail.hover.com.cust.hostedemail.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "perfect" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "perfect"
  type            = "CNAME"
  content         = "8a858d4a-0784-41ba-b318-7fd7c66b9df4.cfargotunnel.com"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "sig1_domainkey" {
  zone_id         = data.cloudflare_zone.zone.id
  name            = "sig1._domainkey"
  type            = "CNAME"
  content         = "sig1.dkim.designbuildautomate.io.at.icloudmailadmin.com"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

# MX Records
# Temporarily removed MX records due to import issues

# TXT Records
# Temporarily removed TXT records due to import issues

# Page Rules
resource "cloudflare_page_rule" "barcall_redirect" {
  zone_id  = data.cloudflare_zone.zone.id
  target   = "barcall.designbuildautomate.io/*"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://apps.apple.com/us/app/barcall/id6456889305?mt=12"
      status_code = 301
    }
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
