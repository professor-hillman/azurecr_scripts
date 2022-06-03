#!/bin/bash

# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.

# ACR_NAME: The name of your Azure Container Registry (use registry name from the main script)
# SERVICE_PRINCIPAL_NAME: Must be unique within your AD tenant (choose your own name)

# Change this to match the ACR name you created in the main script
ACR_NAME='CHANGE_ME_AzureContainerRegistryName'

# Choose a unique name for this service principal ('dockerd', 'acrd', 'dockworker', 'dockergrunt', etc.)
SERVICE_PRINCIPAL_NAME='CHANGE_ME_ServicePrincipalName'

# Obtain the full registry ID
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query "id" --output tsv)

# Create the service principal with rights scoped to the registry.
# Default permissions are for docker pull access. Modify the '--role'
# argument value as desired:
# acrpull:     pull only
# acrpush:     push and pull
# owner:       push, pull, and assign roles
PASSWORD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $ACR_REGISTRY_ID --role acrpull --query "password" --output tsv)
USER_NAME=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[].appId" --output tsv)

# Output the service principal's credentials; use these in your services and
# applications to authenticate to the container registry.
echo "SPN_ID: $USER_NAME"
echo "SPN_PW: $PASSWORD"
