Clear-Host

& .\install-modules.ps1

$Config = Get-Config -File "$PSScriptRoot\config\beta.json"
Invoke-UpdateGameEnvironment -Config $Config
Set-Location $PSScriptRoot
