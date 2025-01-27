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
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "local" {
}

# Set terraform backend to local and disable state locking to ensure read-only
terraform {
  backend "local" {
    workspace_dir = "terraform.tfstate.d"
  }
}
