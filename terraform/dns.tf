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

# DNS Records
resource "cloudflare_record" "root" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "designbuildautomate.io"
  value   = "62.146.224.217"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "www"
  value   = "62.146.224.217"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "n8n" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "n8n"
  value   = "62.146.224.217"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "portainer" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "portainer"
  value   = "62.146.224.217"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "homegrown" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "homegrown"
  value   = "62.146.224.217"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "barcall" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "barcall"
  value   = "192.0.2.1"
  type    = "A"
  proxied = true
}

# Cloudflare Tunnel CNAME Records
resource "cloudflare_record" "automateeverything" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "automateeverything"
  value   = "98c9fe3a-dd79-4d83-89fe-bdd26f7847e5.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "chat" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "chat"
  value   = "a6526d8d-adfe-4761-a7fb-bcc6bd7c2c85.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "perfect" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "perfect"
  value   = "8a858d4a-0784-41ba-b318-7fd7c66b9df4.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

# Lab Environment Records
resource "cloudflare_record" "lab_n8n" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "lab-n8n"
  value   = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "lab_nextcloud" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "lab-nextcloud"
  value   = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "lab_portainer" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "lab-portainer"
  value   = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "lab_rancher" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "lab-rancher"
  value   = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "lab_vc4" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "lab-vc4"
  value   = "7340dae2-9370-4063-a8b3-14af45dfcdd9.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

# Email Records
resource "cloudflare_record" "mx1" {
  zone_id  = data.cloudflare_zone.zone.id
  name     = "@"
  value    = "mx01.mail.icloud.com"
  type     = "MX"
  priority = 10
}

resource "cloudflare_record" "mx2" {
  zone_id  = data.cloudflare_zone.zone.id
  name     = "@"
  value    = "mx02.mail.icloud.com"
  type     = "MX"
  priority = 20
}

resource "cloudflare_record" "mail" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "mail"
  value   = "mail.hover.com.cust.hostedemail.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "dkim" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "sig1._domainkey"
  value   = "sig1.dkim.designbuildautomate.io.at.icloudmailadmin.com"
  type    = "CNAME"
  proxied = false
}

# SPF and Other TXT Records
resource "cloudflare_record" "spf1" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "@"
  value   = "v=spf1 include:icloud.com ~all"
  type    = "TXT"
}

resource "cloudflare_record" "spf2" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "@"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  type    = "TXT"
}

resource "cloudflare_record" "apple_domain" {
  zone_id = data.cloudflare_zone.zone.id
  name    = "@"
  value   = "apple-domain=hvRkCTEXAl9Gk3yc"
  type    = "TXT"
}

# Page Rules
resource "cloudflare_page_rule" "www_redirect" {
  zone_id  = data.cloudflare_zone.zone.id
  target   = "www.designbuildautomate.io/"
  priority = 1

  actions {
    forwarding_url {
      url         = "https://github.com/jtalborough"
      status_code = 301
    }
  }
}

resource "cloudflare_page_rule" "barcall_redirect" {
  zone_id  = data.cloudflare_zone.zone.id
  target   = "barcall.designbuildautomate.io/*"
  priority = 2

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
