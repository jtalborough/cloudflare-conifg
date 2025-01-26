terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "cloudflare" {
  email     = var.cloudflare_email
  api_key   = var.cloudflare_api_key
}

provider "local" {
}

variable "cloudflare_email" {
  description = "Cloudflare account email"
  type        = string
}

variable "cloudflare_api_key" {
  description = "Cloudflare Global API Key"
  type        = string
  sensitive   = true
}

# Set terraform backend to local and disable state locking to ensure read-only
terraform {
  backend "local" {
    workspace_dir = "terraform.tfstate.d"
  }
}
