# Check VM Availability in Regions

### Description of the Script

This Bash script is designed to check the availability of a specific Azure Virtual Machine (VM) SKU (`Standard_NC24ads_A100_v4`) across multiple US regions. The script uses the Azure CLI to query the availability of the specified VM SKU in each region and prints the results in a table format.

#### Breakdown of the Script

1. **Shebang Line**:
   ```shell
   #!/bin/bash
   ```
   This line indicates that the script should be run using the Bash shell.

2. **Variables**:
   ```shell
   VM_SKU="Standard_NC24ads_A100_v4"
   ```
   This variable stores the name of the VM SKU to check for availability.

3. **List of US Regions**:
   ```shell
   US_REGIONS=("eastus" "eastus2" "centralus" "northcentralus" "southcentralus" "westus" "westus2" "westus3")
   ```
   This array contains the list of US regions where the script will check for the availability of the specified VM SKU.

4. **Function to Check VM SKU Availability**:
   ```shell
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
   ```
   - **Function Definition**: The `check_region` function takes a region as an argument and checks if the specified VM SKU is available in that region.
   - **Azure CLI Command**: The `az vm list-sizes` command is used to list the available VM sizes in the specified region. The `--query` parameter filters the results to check if the specified VM SKU is available.
   - **Conditional Check**: The script checks if the `sku_available` variable is empty. If it is, the SKU is not available in that region; otherwise, it is available.
   - **Print Result**: The result is printed in a table format using the `printf` command.

5. **Print Table Header**:
   ```shell
   printf "| %-20s | %-15s |\n" "Region" "SKU Availability"
   printf "| %-20s | %-15s |\n" "--------------------" "---------------"
   ```
   These lines print the header of the table that will display the results.

6. **Loop Through Regions**:
   ```shell
   for region in "${US_REGIONS[@]}"; do
     check_region $region
   done
   ```
   This loop iterates through each region in the `US_REGIONS` array and calls the `check_region` function to check the availability of the VM SKU in each region.
7. **Instructions**
   Save the script to a file, for example, check_vm_sku_availability.sh.
   Make the script executable:
      ```shell
   chmod +x check_vm_sku_availability.sh
      ```
Run the script:
      ```shell
   ./check_vm_sku_availability.sh
      ```
### Summary

This script automates the process of checking the availability of a specific Azure VM SKU across multiple US regions. It uses the Azure CLI to query the availability and prints the results in a neatly formatted table. The script is useful for quickly determining where a particular VM SKU can be deployed within the specified regions.
