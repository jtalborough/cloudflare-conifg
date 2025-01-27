# Cloudflare Infrastructure as Code

This repository contains the Terraform configurations for managing Cloudflare resources for designbuildautomate.io. All changes to the Cloudflare configuration should be made through this repository.

## Repository Structure

```
.
├── .github/
│   └── workflows/
│       └── apply.yml      # CI/CD pipeline
├── scripts/
│   ├── fetch_cloudflare_config.sh  # Fetch all Cloudflare configs
│   ├── fetch_tunnels.sh            # Fetch tunnel configurations
│   └── fetch_zero_trust.sh         # Fetch Zero Trust settings
├── terraform/
│   ├── dns.tf            # DNS records and page rules
│   ├── tunnels.tf        # Cloudflare Tunnel configurations
│   ├── variables.tf      # Variable definitions
│   ├── zero_trust.tf     # Zero Trust settings
│   └── zone_settings.tf  # Zone-level configurations
└── README.md
```

## Components

### DNS Management (`terraform/dns.tf`)
- A records for main services
- CNAME records for Cloudflare Tunnels
- Email configuration (MX, DKIM, SPF)
- Page rules for redirects

### Zero Trust (`terraform/zero_trust.tf`)
- Access applications configuration
- Access policies
- Identity providers (Google OAuth)

### Zone Settings (`terraform/zone_settings.tf`)
- SSL/TLS configuration
- Security settings
- Performance optimizations
- Network configurations

### Tunnels (`terraform/tunnels.tf`)
- AutomateEverything tunnel
- Chat tunnel
- Perfect tunnel
- Lab Environment tunnel with multiple services

## Setup

1. Clone this repository
2. Create `terraform/terraform.tfvars` file with the following variables:
   ```hcl
   cloudflare_email = "your-email"
   cloudflare_api_key = "your-api-key"
   cloudflare_account_id = "your-account-id"
   tunnel_secret_automate_everything = "tunnel-secret"
   tunnel_secret_chat = "tunnel-secret"
   tunnel_secret_perfect = "tunnel-secret"
   tunnel_secret_lab = "tunnel-secret"
   ```

## Usage

### GitHub Actions Workflow
The repository includes a GitHub Actions workflow that automatically:
1. Validates Terraform configurations
2. Generates a plan
3. Applies changes when merged to main

### Manual Deployment
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Scripts

### `scripts/fetch_cloudflare_config.sh`
Fetches current Cloudflare configurations including:
- DNS records
- Zone settings
- WAF rules
- Workers
- Access service tokens

### `scripts/fetch_tunnels.sh`
Fetches configurations for all Cloudflare Tunnels.

## Security
- Sensitive values are stored as GitHub Secrets
- API keys and tunnel secrets are marked as sensitive in Terraform
- Zero Trust access is enforced for all applications

## Best Practices
1. Always make changes through this repository, not directly in Cloudflare UI
2. Review terraform plan output before applying changes
3. Use meaningful commit messages describing the changes
4. Keep secrets in `terraform/terraform.tfvars` and never commit this file

## Maintenance
1. Regularly update Terraform provider versions
2. Monitor GitHub Actions workflow for any failures
3. Review access policies periodically
4. Keep tunnel configurations in sync with local setups