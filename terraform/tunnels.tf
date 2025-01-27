# Cloudflare Tunnels

# AutomateEverything Tunnel
resource "cloudflare_tunnel" "automate_everything" {
  account_id = var.cloudflare_account_id
  name       = "AutomateEverything"
  secret     = var.tunnel_secret_automate_everything
}

resource "cloudflare_tunnel_config" "automate_everything" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.automate_everything.id

  config {
    ingress_rule {
      hostname = "automateeverything.designbuildautomate.io"
      service  = "http://localhost:5678"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}

# Chat Tunnel
resource "cloudflare_tunnel" "chat" {
  account_id = var.cloudflare_account_id
  name       = "Chat"
  secret     = var.tunnel_secret_chat
}

resource "cloudflare_tunnel_config" "chat" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.chat.id

  config {
    ingress_rule {
      hostname = "chat.designbuildautomate.io"
      service  = "http://localhost:3000"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}

# Perfect Tunnel
resource "cloudflare_tunnel" "perfect" {
  account_id = var.cloudflare_account_id
  name       = "Perfect"
  secret     = var.tunnel_secret_perfect
}

resource "cloudflare_tunnel_config" "perfect" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.perfect.id

  config {
    ingress_rule {
      hostname = "perfect.designbuildautomate.io"
      service  = "http://localhost:8080"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}

# Lab Environment Tunnel
resource "cloudflare_tunnel" "lab" {
  account_id = var.cloudflare_account_id
  name       = "Lab"
  secret     = var.tunnel_secret_lab
}

resource "cloudflare_tunnel_config" "lab" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.lab.id

  config {
    ingress_rule {
      hostname = "lab-n8n.designbuildautomate.io"
      service  = "http://localhost:5679"
    }
    ingress_rule {
      hostname = "lab-nextcloud.designbuildautomate.io"
      service  = "http://localhost:8081"
    }
    ingress_rule {
      hostname = "lab-portainer.designbuildautomate.io"
      service  = "http://localhost:9000"
    }
    ingress_rule {
      hostname = "lab-rancher.designbuildautomate.io"
      service  = "http://localhost:8443"
    }
    ingress_rule {
      hostname = "lab-vc4.designbuildautomate.io"
      service  = "http://localhost:8082"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}
