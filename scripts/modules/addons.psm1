using namespace System.IO

function Get-Addon([string] $name, [string] $repository) {
    [string] $downloads = "$env:TEMP\addons"
    Remove-IfExists $downloads

    Write-Verbose -Verbose "Creating download folder"
    New-Item -Path $downloads -ItemType Directory | Out-Null
    Set-Location $downloads
    
    git clone $repository $name

    Set-Location $name

    Remove-IfExists ".gitlab"
    Remove-IfExists ".gitignore"
    Remove-IfExists "changelog.md"

    Get-ChildItem
}

function Remove-IfExists([string] $name) {
    if (Test-Path -Path $name)
    {
        Write-Verbose -Verbose "Removing $name"
        Remove-Item $name -Recurse -Force | Out-Null
    }
}
