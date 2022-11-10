[CmdletBinding()]
param (
    [switch] $extras = $false,
    [switch] $language = $false,
    [switch] $devEnv = $false,
    [switch] $haskell = $false,
    [switch] $java = $false,
    [switch] $php = $false,
    [switch] $optionals = $false
)

function Install-Package {
    param (
        [string]$name,
        [switch]$global = $false
    )

    if ($global) {
        scoop install $name -g
    }
    else {
        scoop install $name
    }
}

function Invoke-WithBucket {
    param (
        [string] $bucket,
        [scriptblock[]] $block
    )
    scoop bucket add $bucket
    $block | ForEach-Object { $_.Invoke() }
    scoop bucket rm $bucket
}

Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
Push-Location ~/scoop/shims

# Basic
scoop bucket add extras
@("git", "aria2", "7zip") | ForEach-Object { Install-Package -name $_ -global }
@("7zip") | ForEach-Object { Install-Package -name $_ -global }

# Fonts
Invoke-WithBucket -bucket "nerd-fonts" { Install-Package -name "FiraCode-NF" -global }

# Tools
@("cmder-full", "ffmpeg", "mingw-winlibs", "sudo", "vim", "vscode") | ForEach-Object { Install-Package -name $_ -global }
@("signal", "bitwarden", "googlechrome" , "imagemagick", "youtube-dl") | ForEach-Object { Install-Package -name $_ }

# Modules
switch ($true) {    
    $extras { @("draw.io", "notion", "libreoffice-stable", "obs-studio") | ForEach-Object { Install-Package -name $_ -global } }
    $language { @("dotnet-sdk", "go", "nodejs-lts", "python", "terraform") | ForEach-Object { Install-Package -name $_ -global } }
    $devEnv { @("make", "github", "postman") | ForEach-Object { Install-Package -name $_ -global } }
    $haskell { @("haskell@8.10.7", "haskell-cabal", "stack") | ForEach-Object { Install-Package -name $_ -global } }
    $java { scoop bucket add java; @("kotlin", "maven", "openjdk8-redhat", "openjdk11") | ForEach-Object { Install-Package -name $_ -global } }
    $php { @("php", "php-xdebug", "composer") | ForEach-Object { Install-Package -name $_ -global } }
    $optionals { @("vcredist2019") | ForEach-Object { Install-Package -name $_ -global } }
}

Pop-Location
