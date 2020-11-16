Clear-Host

& .\install-modules.ps1
Invoke-UpdateGameEnvironment -Config "$PSScriptRoot\config\retail.json"
Set-Location $PSScriptRoot
