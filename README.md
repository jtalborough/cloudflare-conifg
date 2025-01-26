# Cloudflare Configuration Backup

This repository contains Terraform configurations to manage and backup Cloudflare settings for designbuildautomate.io.

## Features

- Zone settings management
- DNS records backup
- SSL/TLS configuration
- Page rules backup
- Zero Trust settings (planned)

## Prerequisites

- Terraform >= 1.0
- Cloudflare account with Global API key
- Domain configured in Cloudflare

## Setup

1. Clone this repository
2. Copy `terraform.tfvars.example` to `terraform.tfvars`
3. Add your Cloudflare credentials to `terraform.tfvars`:
   ```hcl
   cloudflare_email    = "your-email@example.com"
   cloudflare_api_key  = "your-global-api-key"
   ```
4. Initialize Terraform:
   ```bash
   terraform init
   ```
5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Security Notes

- Never commit `terraform.tfvars` or any JSON files containing sensitive data
- All sensitive files are included in `.gitignore`
- Use environment variables for CI/CD pipelines

## Files

- `main.tf` - Provider configuration
- `dns_records.tf` - DNS records configuration
- `zone.tf` - Zone settings
- `variables.tf` - Variable definitions
- `terraform.tfvars.example` - Example variables file