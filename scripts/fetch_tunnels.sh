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
mkdir -p cloudflare_configs/tunnels

# List of tunnel IDs
TUNNEL_IDS=(
    "98c9fe3a-dd79-4d83-89fe-bdd26f7847e5"
    "a6526d8d-adfe-4761-a7fb-bcc6bd7c2c85"
    "8a858d4a-0784-41ba-b318-7fd7c66b9df4"
    "7340dae2-9370-4063-a8b3-14af45dfcdd9"
)

# Fetch tunnel configurations
for TUNNEL_ID in "${TUNNEL_IDS[@]}"; do
    echo "Fetching configuration for tunnel $TUNNEL_ID..."
    curl -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/cfd_tunnel/$TUNNEL_ID" \
         -H "X-Auth-Key: $API_KEY" \
         -H "X-Auth-Email: $EMAIL" \
         -H "Content-Type: application/json" | jq '.' > "cloudflare_configs/tunnels/$TUNNEL_ID.json"
    
    echo "Fetching tunnel connections for $TUNNEL_ID..."
    curl -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/cfd_tunnel/$TUNNEL_ID/connections" \
         -H "X-Auth-Key: $API_KEY" \
         -H "X-Auth-Email: $EMAIL" \
         -H "Content-Type: application/json" | jq '.' > "cloudflare_configs/tunnels/${TUNNEL_ID}_connections.json"
done

echo "Done! Check cloudflare_configs/tunnels/ for all tunnel configurations."
