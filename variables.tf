variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API Token"
  sensitive   = true
}

variable "cloudflare_email" {
  type        = string
  description = "Cloudflare Email"
  sensitive   = true
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare Account ID"
  sensitive   = true
}

variable "google_client_id" {
  type        = string
  description = "Google OAuth Client ID"
  sensitive   = true
}

variable "google_client_secret" {
  type        = string
  description = "Google OAuth Client Secret"
  sensitive   = true
}

variable "cloudflare_api_key" {
  type        = string
  description = "Cloudflare API Key"
  sensitive   = true
}

# Tunnel Secrets
variable "tunnel_secret_automate_everything" {
  type        = string
  description = "Secret for AutomateEverything tunnel"
  sensitive   = true
}

variable "tunnel_secret_chat" {
  type        = string
  description = "Secret for Chat tunnel"
  sensitive   = true
}

variable "tunnel_secret_perfect" {
  type        = string
  description = "Secret for Perfect tunnel"
  sensitive   = true
}

variable "tunnel_secret_lab" {
  type        = string
  description = "Secret for Lab tunnel"
  sensitive   = true
}
