#!/usr/bin/env pwsh

# Retrieve storage account name and container name from environment
$SA=($env:storageAccountName)
$RG=($env:resourceGroupName)
$SB=($env:AZURE_SUBSCRIPTION_ID)
Write-Host "--------------- Info 01 ---------------"
Write-Host "storageAccountName : $SA"
Write-Host "ResourceGroup      : $RG"
Write-Host "Subscryption       : $SB"
Write-Host "---------------------------------------"

Set-AzContext -Subscription $SB
$storageAccount = Get-AzStorageAccount -ResourceGroupName $RG -AccountName $SA
$ctx = $storageAccount.Context

Write-Host "--------------- Info 02 ---------------"
Write-Host "storageAccount    : $storageAccount"
Write-Host "ctx               : $ctx"
Write-Host "---------------------------------------"

Get-ChildItem -File -Recurse -Path "./src" | Set-AzStorageBlobContent -Context $ctx -Container '$web' -Properties @{'ContentType' = 'text/html'} -Force 


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