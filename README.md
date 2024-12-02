# AZD Sample - Static website hosting in Azure Storage
AZD Sample - Static website hosting in Azure Storage

## Requirements

- https://git-scm.com/downloads
- https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#installing-the-msi-package
- ```winget install microsoft.azd```

## Run pwsh
```pwsh```

## Install Az module
```Install-Module -Name Az -Repository PSGallery -Force```

## Clone the repository
```git clone https://github.com/MariuszFerdyn/Static-website-hosting-in-Azure-Storage-AZD.git```

## Go to the project directory
```cd Static-website-hosting-in-Azure-Storage-AZD```

# Authenticate using azd
```azd auth login```

# Authenticate using pwsh
```Connect-AzAccount -UseDeviceAuthentication```

# Deploy solution
```azd up```