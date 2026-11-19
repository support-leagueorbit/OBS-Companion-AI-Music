# AI Music installer for Windows (by LeagueOrbit).
#
#   irm https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases/latest/download/install.ps1 | iex
#
# Downloads only from this project's GitHub Releases and checks every file against the
# release's SHA256SUMS before using it. Installs for the current Windows user (no
# administrator rights) into %LOCALAPPDATA%\Programs\AI Music.
#
# Options (environment variables, set before running):
#   AI_MUSIC_SOUNDS        "all", "none" (default), or packs, e.g. "piano,drums,guitar-acoustic"
#   AI_MUSIC_RUN_AT_LOGIN  "1" to start AI Music when you sign in
#   AI_MUSIC_NO_START      "1" to not open AI Music at the end

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue' # much faster downloads on Windows PowerShell 5.1

$Repo = 'https://github.com/support-leagueorbit/OBS-Companion-AI-Music/releases'
$SoundsTag = 'sounds-v1'
$SoundsVersion = '1'
$AppAsset = 'ai-music-windows-x64.exe'

function Fail([string]$msg) {
    Write-Host "AI Music install failed: $msg" -ForegroundColor Red
    throw $msg
}

function Get-ReleaseBase {
    $b = $env:AI_MUSIC_RELEASE_BASE # for testing against a local copy of a release
    if (-not $b) { return $Repo }
    $u = [Uri]$b
    if ($u.Scheme -ne 'https' -and -not ($u.Scheme -eq 'http' -and ($u.Host -eq '127.0.0.1' -or $u.Host -eq 'localhost'))) {
        Fail "AI_MUSIC_RELEASE_BASE must be an https address"
    }
    return $b.TrimEnd('/')
}

function Get-File([string]$url, [string]$dest) {
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
    } catch {
        Fail "could not download $url ($($_.Exception.Message))"
    }
}

# Reads a SHA256SUMS file into a name -> checksum table ("hash  name" or "hash *name").
function Read-Sums([string]$path) {
    $t = @{}
    foreach ($line in Get-Content -LiteralPath $path) {
        if ($line -match '^([0-9a-fA-F]{64}) [ *](.+)$') { $t[$Matches[2].Trim()] = $Matches[1].ToLower() }
    }
    return $t
}

function Test-Sum([string]$path, [string]$name, $sums) {
    if (-not $sums.ContainsKey($name)) { Fail "$name is not listed in SHA256SUMS" }
    $got = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLower()
    if ($got -ne $sums[$name]) {
        Remove-Item -LiteralPath $path -Force -ErrorAction SilentlyContinue
        Fail "checksum mismatch for $name (got $got, expected $($sums[$name])). Nothing was installed from it."
    }
}

function Install-AIMusic {
    if ([Environment]::OSVersion.Platform -ne 'Win32NT') { Fail "this installer is for Windows; on macOS or Linux use install.sh" }
    if (-not [Environment]::Is64BitOperatingSystem) { Fail "AI Music needs 64-bit Windows" }
    try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12 } catch {}

    $base = Get-ReleaseBase
    $work = Join-Path ([IO.Path]::GetTempPath()) ("ai-music-install-" + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $work | Out-Null
    try {
        Write-Host "Downloading AI Music..."
        $sumsPath = Join-Path $work 'SHA256SUMS'
        Get-File "$base/latest/download/SHA256SUMS" $sumsPath
        $sums = Read-Sums $sumsPath
        $exe = Join-Path $work $AppAsset
        Get-File "$base/latest/download/$AppAsset" $exe
        Test-Sum $exe $AppAsset $sums
        Write-Host "Checksum OK."

        $iargs = @('install', '-quiet')
        if ($env:AI_MUSIC_RUN_AT_LOGIN -eq '1') { $iargs += '-run-at-login' }
        $out = & $exe @iargs 2>&1 | Out-String
        if ($LASTEXITCODE -ne 0) { Fail "the app's installer said: $($out.Trim())" }
        $installed = Join-Path $env:LOCALAPPDATA 'Programs\AI Music\ai-music.exe'
        if ($out -match 'installed:\s*(.+)') { $installed = $Matches[1].Trim() }
        Write-Host "Installed: $installed"

        $want = ("" + $env:AI_MUSIC_SOUNDS).Trim().ToLower()
        if ($want -and $want -ne 'none') {
            $ssums = Join-Path $work 'SOUNDS-SHA256SUMS'
            Get-File "$base/download/$SoundsTag/SHA256SUMS" $ssums
            $packSums = Read-Sums $ssums
            $re = '^ai-music-sounds-(.+)-' + [Regex]::Escape($SoundsVersion) + '\.zip$'
            $available = @($packSums.Keys | Where-Object { $_ -match $re } | ForEach-Object { ($_ -replace $re, '$1') } | Sort-Object)
            if ($want -eq 'all') { $names = $available } else { $names = @($want -split '[,; ]+' | Where-Object { $_ }) }
            foreach ($n in $names) {
                if ($available -notcontains $n) { Fail "unknown sound pack '$n'. Packs: $($available -join ', ')" }
            }
            $i = 0
            foreach ($n in $names) {
                $i++
                $file = "ai-music-sounds-$n-$SoundsVersion.zip"
                Write-Host "Sound pack $i of $($names.Count): $n..."
                $zip = Join-Path $work $file
                Get-File "$base/download/$SoundsTag/$file" $zip
                Test-Sum $zip $file $packSums
                $o = & $installed sounds install -file $zip -sha256 $packSums[$file] 2>&1 | Out-String
                if ($LASTEXITCODE -ne 0) { Fail "installing ${n}: $($o.Trim())" }
                Remove-Item -LiteralPath $zip -Force
            }
            if ($names.Count -gt 0) { Write-Host "Sound packs installed. If AI Music was already running, quit it from the tray icon and open it again." }
        }

        Write-Host "Done. Find AI Music in the Start menu." -ForegroundColor Green
        if ($env:AI_MUSIC_NO_START -ne '1') { Start-Process -FilePath $installed }
    } finally {
        Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Install-AIMusic
