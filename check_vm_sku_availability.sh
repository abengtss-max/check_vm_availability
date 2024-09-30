#!/bin/bash

# Variables
VM_SKU="Standard_NC24ads_A100_v4"

# List of US regions to check
US_REGIONS=("eastus" "eastus2" "centralus" "northcentralus" "southcentralus" "westus" "westus2" "westus3")

# Function to check VM SKU availability
check_region() {
  local region=$1

  # Check if the VM SKU is available in the region
  sku_available=$(az vm list-sizes --location $region --query "[?name=='$VM_SKU']" -o tsv)

  if [ -z "$sku_available" ]; then
    sku_status="Not Available"
  else
    sku_status="Available"
  fi

  # Print the result in table format
  printf "| %-20s | %-15s |\n" "$region" "$sku_status"
}

# Print table header
printf "| %-20s | %-15s |\n" "Region" "SKU Availability"
printf "| %-20s | %-15s |\n" "--------------------" "---------------"

# Loop through all US regions and check availability
for region in "${US_REGIONS[@]}"; do
  check_region $region
done
