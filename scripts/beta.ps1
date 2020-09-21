Clear-Host

& .\install-modules.ps1

Write-Verbose -Verbose "Creating temp folder"
Invoke-CreateAddonsFolder

$Config = Get-Config -File "$PSScriptRoot\config\beta.json"
foreach($addon in $Config.addons)
{
    Get-Addon -Name $addon.name -Branch $addon.branch -Repository $addon.repository

    foreach($folder in $addon.folders)
    {
        Copy-FolderToAddons -Name $addon.name -Folder $folder -Addons $config.folder
    }
}

Write-Verbose -Verbose "Script Complete"

Set-Location $PSScriptRoot