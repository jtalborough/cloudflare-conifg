#!/bin/bash

# Source variables from terraform.tfvars
API_KEY=$(grep cloudflare_api_key terraform.tfvars | cut -d'=' -f2 | tr -d ' "')
EMAIL=$(grep cloudflare_email terraform.tfvars | cut -d'=' -f2 | tr -d ' "')
ACCOUNT_ID=$(grep cloudflare_account_id terraform.tfvars | cut -d'=' -f2 | tr -d ' "')

if [ -z "$API_KEY" ] || [ -z "$EMAIL" ] || [ -z "$ACCOUNT_ID" ]; then
    echo "Error: Could not read API key, Email, or Account ID from terraform.tfvars"
    exit 1
fi

# Fetch Zero Trust Applications
echo "Fetching Zero Trust Applications..."
curl -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/access/apps" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > zero_trust_apps.json

# Fetch Access Policies for each application
echo "Fetching Access Policies..."
mkdir -p zero_trust_policies
for APP_ID in $(jq -r '.result[].id' zero_trust_apps.json); do
    curl -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/access/apps/$APP_ID/policies" \
         -H "X-Auth-Key: $API_KEY" \
         -H "X-Auth-Email: $EMAIL" \
         -H "Content-Type: application/json" | jq '.' > "zero_trust_policies/$APP_ID.json"
done

# Fetch Access Groups
echo "Fetching Access Groups..."
curl -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/access/groups" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > zero_trust_groups.json

# Fetch Identity Providers
echo "Fetching Identity Providers..."
curl -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/access/identity_providers" \
     -H "X-Auth-Key: $API_KEY" \
     -H "X-Auth-Email: $EMAIL" \
     -H "Content-Type: application/json" | jq '.' > zero_trust_idps.json

echo "Done! Check the following files:"
echo "- zero_trust_apps.json"
echo "- zero_trust_policies/*.json"
echo "- zero_trust_groups.json"
echo "- zero_trust_idps.json"
