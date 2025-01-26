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
