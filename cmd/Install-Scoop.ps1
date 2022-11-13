<#
.DESCRIPTION
Install scoop and some package sets.
MUST run with administration permission.
#>

[CmdletBinding()]
param (
    # Whether to install basic sets. Default true.
    [switch] $Basic,
    # Whether to install fonts. Default true.
    [switch] $Fonts,
    # Modules to be installed with scoop.
    [Parameter(ValueFromPipeline)]
    [ValidateSet("Daily", "CLI", "Extra", "DevEnv", "DevOps", "NodeJS", "Python", "DotNet", "Go", "Haskell", "Java", "PHP")]
    [ValidateNotNullOrEmpty]
    [string[]] $Modules,
    # Whether to install packages globally. Default false.
    [switch] $Globally = $false
)

function Install-Package {
    param (
        [string]$Name
    )

    if ($Globally) {
        Write-Host scoop install $Name -g
    }
    else {
        Write-Host scoop install $Name
    }
}

function Add-Bucket {
    param (
        [string] $Name
    )
    scoop bucket add $Name
}

function Invoke-WithBucket {
    param (
        [string] $Bucket,
        [scriptblock[]] $Block
    )
    scoop bucket add $Bucket
    $Block | ForEach-Object { $_.Invoke() }
    scoop bucket rm $Bucket
}

function Convert-Bucket {
    param (
        [string]$Module
    )
    switch ($Module) {
        Java { @("java") }
        Default {}
    }
}


function Convert-Package {
    param (
        [string]$Module
    )
    switch ($Module) {
        Daily { @("signal", "bitwarden", "vscode", "notion") }
        CLI { @("cmder-full", "ffmpeg", "sudo", "vim", "imagemagick", "youtube-dl", "vcredist2019", "lynx") }
        Extra { @("libreoffice-stable", "obs-studio", "calibre-normal") }
        DevEnv { @("vscode", "github", "postman", "mingw-winlibs") }

        DevOps { @("terraform") }
        NodeJS { @("nodejs-lts", "pnpm") }
        Python { @("python") }
        DotNet { @("dotnet-sdk") }
        Go { @("go") }
        Haskell { @("mingw-winlibs", "make", "haskell@8.10.7", "haskell-cabal", "stack") }
        Java { @("kotlin", "scala", "maven", "openjdk8-redhat", "openjdk11") }
        PHP { @("php", "php-xdebug", "composer") }
    }
}

if (-not($Basic -and (Test-Path "~/scoop/shims"))) {
    Write-Error "No scoop installed, please set Basic to true to install scoop"
}

if ($Basic) {
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

Push-Location ~/scoop/shims

if ($Basic) {
    Add-Bucket extras
    @("git", "aria2", "7zip") | ForEach-Object { Install-Package -Globally -Name $_ }
}

if ($Fonts) {
    Invoke-WithBucket -Bucket "nerd-fonts" { Install-Package -Globally -Name "FiraCode-NF" }
}

$Modules | ForEach-Object { Convert-Bucket $_ } | Sort-Object -Unique | ForEach-Object { Add-Bucket $_ }
$Modules | ForEach-Object { Convert-Package $_ } | Sort-Object -Unique | ForEach-Object { Install-Package -Name $_ }

Pop-Location
