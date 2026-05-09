param(
    [string]$ManifestUrl = "https://raw.githubusercontent.com/Raytolfas/RayQuiroAssets/main/update.json",
    [string]$InstallRoot = "C:\rayquiro"
)

$ErrorActionPreference = "Stop"
$host.UI.RawUI.WindowTitle = "RayQuiro Installer"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Write-Step([string]$text) {
    Write-Host "[RayQuiro Installer] $text"
}

function Download-File([string]$url, [string]$outFile) {
    try {
        Invoke-WebRequest -Uri $url -OutFile $outFile -UseBasicParsing
        return
    } catch {
        if (Get-Command curl.exe -ErrorAction SilentlyContinue) {
            & curl.exe -L --fail --silent --show-error $url -o $outFile
            if ($LASTEXITCODE -eq 0) {
                return
            }
        }
        throw
    }
}

function Add-ToUserPath([string]$targetPath) {
    $current = [Environment]::GetEnvironmentVariable("Path", "User")
    if ([string]::IsNullOrWhiteSpace($current)) {
        [Environment]::SetEnvironmentVariable("Path", $targetPath, "User")
        return $true
    }

    $parts = $current.Split(";") | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    foreach ($part in $parts) {
        if ($part.TrimEnd("\") -ieq $targetPath.TrimEnd("\")) {
            return $true
        }
    }

    [Environment]::SetEnvironmentVariable("Path", "$current;$targetPath", "User")
    return $true
}

$installBin = Join-Path $InstallRoot "bin"
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) "rayquiro-installer"
$downloadPath = Join-Path $tempRoot "rqio.exe"
$manifestPath = Join-Path $tempRoot "update.json"

Write-Step "Preparing temporary folder"
New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null

Write-Step "Downloading update manifest"
Download-File $ManifestUrl $manifestPath
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json

$downloadUrl = $manifest.downloadUrl
if ([string]::IsNullOrWhiteSpace($downloadUrl)) {
    $downloadUrl = $manifest.download_url
}

if ([string]::IsNullOrWhiteSpace($downloadUrl)) {
    throw "update.json does not contain downloadUrl or download_url"
}

Write-Step "Downloading rqio.exe"
Download-File $downloadUrl $downloadPath

Write-Step "Creating install folders"
New-Item -ItemType Directory -Force -Path $installBin | Out-Null

Write-Step "Installing rqio.exe to $installBin"
Copy-Item -LiteralPath $downloadPath -Destination (Join-Path $installBin "rqio.exe") -Force

Write-Step "Updating user PATH"
Add-ToUserPath $installBin | Out-Null

Write-Step "Installation complete"
Write-Host ""
Write-Host "RayQuiro was installed to: $installBin"
Write-Host "Restart your terminal, then run:"
Write-Host "rqio version"
