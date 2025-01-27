#!/bin/bash

# Source variables from terraform.tfvars
API_KEY=$(grep cloudflare_api_key terraform.tfvars | cut -d'=' -f2 | tr -d ' "')
EMAIL=$(grep cloudflare_email terraform.tfvars | cut -d'=' -f2 | tr -d ' "')
ACCOUNT_ID=$(grep cloudflare_account_id terraform.tfvars | cut -d'=' -f2 | tr -d ' "')

if [ -z "$API_KEY" ] || [ -z "$EMAIL" ] || [ -z "$ACCOUNT_ID" ]; then
    echo "Error: Could not read required variables from terraform.tfvars"
    exit 1
fi

# Create configs directory
mkdir -p cloudflare_configs

# First, get the zone ID for designbuildautomate.io
echo "Fetching Zone ID..."
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=designbuildautomate.io" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq -r '.result[0].id')

if [ -z "$ZONE_ID" ]; then
    echo "Error: Could not fetch zone ID"
    exit 1
fi

echo "Found Zone ID: $ZONE_ID"

# Fetch DNS Records
echo "Fetching DNS Records..."
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > cloudflare_configs/dns_records.json

# Fetch Zone Settings
echo "Fetching Zone Settings..."
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/settings" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > cloudflare_configs/zone_settings.json

# Fetch Page Rules
echo "Fetching Page Rules..."
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/pagerules" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > cloudflare_configs/page_rules.json

# Fetch WAF Rules
echo "Fetching WAF Rules..."
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/firewall/rules" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > cloudflare_configs/waf_rules.json

# Fetch Custom SSL Certificates
echo "Fetching Custom SSL Certificates..."
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/custom_certificates" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > cloudflare_configs/ssl_certificates.json

# Fetch Workers
echo "Fetching Workers..."
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/workers/routes" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > cloudflare_configs/workers.json

# Fetch Access Service Tokens
echo "Fetching Access Service Tokens..."
curl -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/access/service_tokens" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > cloudflare_configs/service_tokens.json

echo "Done! Check the cloudflare_configs directory for all configuration files."
