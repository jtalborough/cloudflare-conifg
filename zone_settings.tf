# Zone Settings
resource "cloudflare_zone_settings_override" "zone_settings" {
  zone_id = data.cloudflare_zone.zone.id
  settings {
    # Security
    ssl                      = "full"
    security_level           = "medium"
    min_tls_version         = "1.0"
    tls_1_3                 = "zrt"
    automatic_https_rewrites = "on"
    opportunistic_encryption = "on"
    always_use_https        = "on"
    browser_check           = "on"
    challenge_ttl           = 1800
    privacy_pass            = "on"
    security_header {
      enabled = false
    }

    # Performance
    brotli                  = "on"
    browser_cache_ttl      = 14400
    cache_level            = "aggressive"
    edge_cache_ttl        = 7200
    http2                  = "on"
    http3                  = "on"
    0rtt                   = "on"
    max_upload            = 100
    minify {
      css  = "off"
      html = "off"
      js   = "off"
    }
    
    # Network
    websockets             = "on"
    ip_geolocation        = "on"
    ipv6                  = "on"
    opportunistic_onion   = "on"
    proxy_read_timeout    = 100
    pq_keyex             = "on"
    cname_flattening     = "flatten_at_root"
    hotlink_protection   = "on"
    email_obfuscation    = "on"
    server_side_exclude  = "on"
    advanced_ddos        = "on"
    ech                  = "on"
  }
}
