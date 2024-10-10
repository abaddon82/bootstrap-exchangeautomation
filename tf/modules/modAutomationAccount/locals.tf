locals {
    testScriptUrl                   = "https://raw.githubusercontent.com/abaddon82/bootstrap-exchangeautomation/refs/heads/main/runbooks/Test-ExchangeConnectivity.ps1"
    mgGraphModuleUrl                = "https://www.powershellgallery.com/api/v2/package/Microsoft.Graph/${var.msGraphModuleVersion}"
    mgGraphAuthModuleUrl            = "https://www.powershellgallery.com/api/v2/package/Microsoft.Graph.Authentication/${var.msGraphModuleVersion}"
    mgGraphIdDirMgmtModuleUrl       = "https://www.powershellgallery.com/api/v2/package/Microsoft.Graph.Identity.DirectoryManagement/${var.msGraphModuleVersion}"
    exoMgmtModuleUrl                = "https://www.powershellgallery.com/api/v2/package/ExchangeOnlineManagement/${var.exModuleVersion}"
}