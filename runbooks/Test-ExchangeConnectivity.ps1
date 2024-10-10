$ErrorActionPreference = 'Stop'

try {

    Write-Output "Connecting to Microsoft Graph"
    $MGConnectionResult = Connect-MgGraph -ManagedIdentity -NoWelcome

    Write-Output "Retrieving initial tenant domain"
    $InitialDomain = Get-MgDomain | Where-Object { $_.IsInitial -eq $True } | Select-Object -ExpandProperty Id

    Write-Output "Connecting to Exchange Online"
    $ExchangeConnectionResult = Connect-ExchangeOnline -ManagedIdentity -Organization $InitialDomain

    Write-Output "Running Exchange cmdlet for testing"
    $AcceptedDomains = Get-AcceptedDomain

    Write-Output "Everything works! You can now create new runbooks or replace this one to do your Exchange management tasks."

} catch {
    Write-Error $_
}