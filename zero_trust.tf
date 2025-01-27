# Zero Trust configuration requires additional permissions
# The following configuration is commented out until proper permissions are granted

# # Get Zero Trust Access Applications
# data "cloudflare_zero_trust_access_application" "apps" {
#   account_id = var.cloudflare_account_id
#   domain     = "designbuildautomate.io"
# }

# # Get Zero Trust Access Identity Providers
# data "cloudflare_zero_trust_access_identity_provider" "idps" {
#   account_id = var.cloudflare_account_id
#   name       = "Google"  # Adjust if using a different provider
# }

# # Output the configurations
# output "access_applications" {
#   value     = data.cloudflare_zero_trust_access_application.apps
#   sensitive = true
# }

# output "identity_providers" {
#   value     = data.cloudflare_zero_trust_access_identity_provider.idps
#   sensitive = true
# }

# Zero Trust Configuration

# Access Applications
resource "cloudflare_access_application" "n8n_api" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "n8n api"
  domain              = "designbuildautomate.io/n8n/api/v1/*"
  type                = "self_hosted"
  session_duration    = "24h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "perfect" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "Perfect"
  domain              = "perfect.designbuildautomate.io"
  type                = "self_hosted"
  session_duration    = "730h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "dba_cloud" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "DesignBuildAutomate-Cloud"
  domain              = "designbuildautomate.io"
  type                = "self_hosted"
  session_duration    = "0s"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "chat" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "chat"
  domain              = "chat.designbuildautomate.io"
  type                = "self_hosted"
  session_duration    = "336h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "ae_n8n" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "ae-n8n"
  domain              = "n8n.automateeverything.cc"
  type                = "self_hosted"
  session_duration    = "24h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "automate_everything" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "AutomateEverything"
  domain              = "automateeverything.designbuildautomate.io"
  type                = "self_hosted"
  session_duration    = "168h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "dba_webhook" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "DesignBuildAutomate - Webhook"
  domain              = "designbuildautomate.io/n8n/webhook*"
  type                = "self_hosted"
  session_duration    = "730h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "dba_callback" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "DesignBuildAutomate Callback"
  domain              = "designbuildautomate.io/n8n/rest/oauth2-credential/callback"
  type                = "self_hosted"
  session_duration    = "24h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "dba_lab" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "DesignBuildAutomate-Lab"
  domain              = "lab-*.designbuildautomate.io"
  type                = "self_hosted"
  session_duration    = "168h"
  app_launcher_visible = true
}

resource "cloudflare_access_application" "warp_login" {
  zone_id             = data.cloudflare_zone.zone.id
  name                = "Warp Login App"
  domain              = "designbuildautomate.cloudflareaccess.com/warp"
  type                = "warp"
  session_duration    = "24h"
  app_launcher_visible = false
}

# Access Groups
resource "cloudflare_access_group" "jta_admin" {
  account_id = var.cloudflare_account_id
  name       = "jta-admin"

  include {
    email = ["jtalborough@gmail.com"]
  }
}

# Access Policies
resource "cloudflare_access_policy" "n8n_api_policy" {
  application_id = cloudflare_access_application.n8n_api.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "n8n API"
  precedence    = "1"
  decision      = "bypass"
}

resource "cloudflare_access_policy" "perfect_policy" {
  application_id = cloudflare_access_application.perfect.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "Allow"
  precedence    = "1"
  decision      = "allow"

  include {
    group = [cloudflare_access_group.jta_admin.id]
  }
}

resource "cloudflare_access_policy" "dba_cloud_policy" {
  application_id = cloudflare_access_application.dba_cloud.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "jta-admin"
  precedence    = "1"
  decision      = "allow"

  include {
    group = [cloudflare_access_group.jta_admin.id]
  }
}

resource "cloudflare_access_policy" "chat_policy" {
  application_id = cloudflare_access_application.chat.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "chat"
  precedence    = "1"
  decision      = "allow"

  include {
    group = [cloudflare_access_group.jta_admin.id]
  }
}

resource "cloudflare_access_policy" "chat_internal_policy" {
  application_id = cloudflare_access_application.chat.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "Allow from within"
  precedence    = "2"
  decision      = "allow"

  include {
    ip = ["192.168.1.0/24"]
  }
}

resource "cloudflare_access_policy" "ae_n8n_policy" {
  application_id = cloudflare_access_application.ae_n8n.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "admin"
  precedence    = "1"
  decision      = "allow"

  include {
    group = [cloudflare_access_group.jta_admin.id]
  }
}

resource "cloudflare_access_policy" "automate_everything_policy" {
  application_id = cloudflare_access_application.automate_everything.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "jta-admin"
  precedence    = "1"
  decision      = "allow"

  include {
    group = [cloudflare_access_group.jta_admin.id]
  }
}

resource "cloudflare_access_policy" "dba_webhook_policy" {
  application_id = cloudflare_access_application.dba_webhook.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "Allow"
  precedence    = "1"
  decision      = "allow"
}

resource "cloudflare_access_policy" "dba_callback_policy" {
  application_id = cloudflare_access_application.dba_callback.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "Cloud-Callback"
  precedence    = "1"
  decision      = "bypass"
}

resource "cloudflare_access_policy" "dba_lab_policy" {
  application_id = cloudflare_access_application.dba_lab.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "jta-admin"
  precedence    = "1"
  decision      = "allow"

  include {
    group = [cloudflare_access_group.jta_admin.id]
  }
}

resource "cloudflare_access_policy" "dba_lab_bypass_policy" {
  application_id = cloudflare_access_application.dba_lab.id
  zone_id       = data.cloudflare_zone.zone.id
  name          = "Bypass"
  precedence    = "2"
  decision      = "bypass"
}

# Identity Providers
resource "cloudflare_access_identity_provider" "google_oauth" {
  account_id = var.cloudflare_account_id
  name       = "Google OAuth"
  type       = "google"
  config {
    client_id     = var.google_client_id
    client_secret = var.google_client_secret
  }
}
