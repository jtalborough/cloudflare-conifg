# Cloudflare Configuration for designbuildautomate.io

This repository contains the complete Terraform configuration for managing Cloudflare settings for designbuildautomate.io. It includes DNS records, zone settings, and Zero Trust configurations.

## Repository Structure

- `dns.tf` - DNS records and zone settings
- `dns_records.tf` - Additional DNS-related configurations
- `zero_trust.tf` - Zero Trust settings
- `main.tf` - Main Terraform configuration
- `variables.tf` - Variable definitions
- `terraform.tfvars` - Variable values (gitignored)

## Prerequisites

1. Terraform installed (version ~> 1.5.0)
2. Cloudflare account with:
   - API Token
   - Account Email
   - Account ID

## Local Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/jtalborough/cloudflare-conifg.git
   cd cloudflare-conifg
   ```

2. Create `terraform.tfvars` file:
   ```hcl
   cloudflare_api_token = "your-api-token"
   cloudflare_email     = "your-email"
   cloudflare_account_id = "your-account-id"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

## Making Changes

### Local Development

1. Create a new branch:
   ```bash
   git checkout -b your-feature-branch
   ```

2. Make your changes to the configuration files

3. Test your changes:
   ```bash
   terraform fmt      # Format code
   terraform validate # Validate configuration
   terraform plan    # Preview changes
   ```

4. Commit and push your changes:
   ```bash
   git add .
   git commit -m "description of changes"
   git push origin your-feature-branch
   ```

5. Create a Pull Request on GitHub

### Automated Workflow

This repository uses GitHub Actions for automated testing and deployment:

1. On Pull Request:
   - Runs format checks
   - Validates configuration
   - Generates and displays plan
   - Adds plan output to PR comments

2. On Merge to Main:
   - Automatically applies changes to production

## GitHub Secrets

The following secrets need to be set in your GitHub repository:

- `CLOUDFLARE_API_TOKEN` - Your Cloudflare API token
- `CLOUDFLARE_EMAIL` - Your Cloudflare account email
- `CLOUDFLARE_ACCOUNT_ID` - Your Cloudflare account ID

## Files Generated

- `cloudflare_config.json` - Current Cloudflare configuration
- `dns_records.json` - DNS records export
- `page_rules.json` - Page rules configuration
- `zone_settings.json` - Zone settings export

## Utility Scripts

- `fetch_dns.sh` - Script to fetch current DNS records from Cloudflare

## Best Practices

1. Always create a new branch for changes
2. Use meaningful commit messages
3. Review the `terraform plan` output carefully
4. Use Pull Requests for all production changes
5. Keep sensitive information in `terraform.tfvars` (gitignored)

## Support

For issues or questions, please create a GitHub issue in this repository.