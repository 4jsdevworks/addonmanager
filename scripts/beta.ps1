Clear-Host

& .\install-modules.ps1

Write-Verbose -Verbose "downloading elvui"
get-addon -name "ElvUI" -repository "https://git.tukui.org/elvui/elvui.git"

Set-Location $PSScriptRoot
