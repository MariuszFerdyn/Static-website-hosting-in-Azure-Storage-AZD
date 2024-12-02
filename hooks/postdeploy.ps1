#!/usr/bin/env pwsh

# Retrieve storage account name and container name from environment

Write-Host "----- Info -----"
Write-Host "storageAccountName: $env:storageAccountName"
Write-Host "ResourceGroup:      $env:resourceGroupName"
Write-Host "----------------"

$storageAccountName = (azd env get-values | Where-Object { $_ -match "AZURE_STORAGE_ACCOUNT_NAME" }) -replace ".*=", ""
$containerName = (azd env get-values | Where-Object { $_ -match "AZURE_CONTAINER_NAME" }) -replace ".*=", ""

exit 0
# Verify storage account exists
try {
    $storageAccount = az storage account show --name $storageAccountName | ConvertFrom-Json
    if (-not $storageAccount) {
        throw "Storage account not found"
    }
}
catch {
    Write-Error "Error accessing storage account: $_"
    exit 1
}

# Upload files to blob storage
try {
    # Upload 1.txt
    az storage blob upload `
        --account-name $storageAccountName `
        --container-name $containerName `
        --file "./src/1.txt" `
        --name "1.txt"

    # Upload 2.txt
    az storage blob upload `
        --account-name $storageAccountName `
        --container-name $containerName `
        --file "./src/2.txt" `
        --name "2.txt"

    Write-Output "Files uploaded successfully!"
}
catch {
    Write-Error "Error uploading files: $_"
    exit 1
}