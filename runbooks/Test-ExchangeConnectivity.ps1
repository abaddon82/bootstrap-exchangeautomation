$ErrorActionPreference = 'Stop'

try {
    Write-Output "Connecting to Azure"
    $AzureConnectionResult = Connect-AzAccount -Identity
    Write-Output "Retrieving default tenant domain"
    $DefaultDomain = Get-AzTenant | Select-Object -ExpandProperty DefaultDomain
    Write-Output "Connecting to Exchange Online"
    $ExchangeConnectionResult = Connect-ExchangeOnline -ManagedIdentity -Organization $DefaultDomain
    Write-Output "Running Exchange cmdlet for testing"
    $AcceptedDomains = Get-AcceptedDomain
    Write-Output "Everything works!"
} catch {
    Write-Error "There seems to be an error`: $_"
}