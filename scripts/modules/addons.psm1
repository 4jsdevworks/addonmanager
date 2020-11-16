using namespace System.IO

[string] $downloads = "$env:TEMP\addons"

function Invoke-UpdateGameEnvironment([string] $ConfigFile) {
    $Config = Get-Config -File $ConfigFile
    Write-Verbose -Verbose "Creating temp folder"
    Invoke-CreateAddonsFolder

    foreach($addon in $Config.addons)
    {
        Get-Addon -Name $addon.name -Branch $addon.branch -Repository $addon.repository

        foreach($folder in $addon.folders)
        {
            Copy-FolderToAddons -Name $addon.name -Folder $folder -Addons $config.folder
        }
    }

    Write-Verbose -Verbose "Script Complete"
}

function Get-Config([string] $File) {
    return Get-Content $File | ConvertFrom-Json
}

function Invoke-CreateAddonsFolder() {
    if ((Test-Path -Path $downloads) -eq $false)
    {
        Write-Verbose -Verbose "Creating download folder $downloads"
        New-Item -Path $downloads -ItemType Directory | Out-Null
    }

    Write-Verbose -Verbose "$downloads is now the current directory"
    Set-Location $downloads
}

function Get-Addon([string] $Name, [string] $Branch, [string] $Repository) {
    if ((Test-Path -Path $Name) -eq $false)
    {
        Write-Verbose -Verbose "Cloning Repo $Repository into $downloads\$name"
        git clone $Repository $Name
    }

    
    Write-Verbose -Verbose "$downloads\$name is now the current directory"
    Set-Location $Name

    Write-Verbose -Verbose "Switching to the $Branch branch in $Repository"
    git checkout $Branch
    git pull
}


function Copy-FolderToAddons([string] $Name, [string] $Folder, [string] $Addons) {
    $source = "$downloads\$Name\$Folder"
    $destination = "$Addons\$Folder"

    Remove-IfExists $destination

    Write-Verbose -Verbose "Copying $Name to $Addons"
    Copy-Item -Path $source -Destination $destination -Recurse
}


function Remove-IfExists([string] $Name) {
    if (Test-Path -Path $Name)
    {
        Write-Verbose -Verbose "Removing $Name"
        Remove-Item $Name -Recurse -Force | Out-Null
    }
}

Export-ModuleMember -Function '*'