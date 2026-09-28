$enc = New-Object System.Text.UTF8Encoding($false)
$TOKEN = [Environment]::GetEnvironmentVariable('VERCEL_TOKEN','User'); if (-not $TOKEN) { throw "Falta la variable de entorno VERCEL_TOKEN" }
$TEAM  = "team_XYsFDYqhJk3U1rmm9ejyhvnY"
$PROJ  = "prj_TEPIShAf5oL9DXIkNEv7bhxsO8aC"
$BASE  = "C:\Users\User\.claude\navia-website"

$headers = @{ Authorization = "Bearer $TOKEN"; "Content-Type" = "application/json" }

# Files to include in this deployment (all blog HTMLs + root files)
$fileMap = @()

# All blog HTML files
Get-ChildItem "$BASE\blog" -Filter "*.html" | ForEach-Object {
    $fileMap += @{ local = $_.FullName; rel = "blog/" + $_.Name }
}

# Blog JS/CSS assets (related.js, etc.)
Get-ChildItem "$BASE\blog" -Include "*.js","*.css" -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    $fileMap += @{ local = $_.FullName; rel = "blog/" + $_.Name }
}

# All root HTML files (auto — evita que falten paginas como gracias.html)
Get-ChildItem $BASE -Filter "*.html" | Where-Object { $_.Name -notmatch '^tpl-' } | ForEach-Object {
    $fileMap += @{ local = $_.FullName; rel = $_.Name }
}

# Root non-HTML assets (css, js, imagenes, config) — glob para NO perder ninguno (ej: destino.css)
Get-ChildItem $BASE -File | Where-Object {
    $_.Extension -in ".css",".js",".webp",".png",".jpg",".jpeg",".svg",".ico",".gif",".woff",".woff2",".ttf",".xml",".txt" -or $_.Name -eq "vercel.json"
} | ForEach-Object {
    $fileMap += @{ local = $_.FullName; rel = $_.Name }
}

# JS folder
Get-ChildItem "$BASE\js" -ErrorAction SilentlyContinue | ForEach-Object {
    $fileMap += @{ local = $_.FullName; rel = "js/" + $_.Name }
}

# img/ folder (recursivo — fotos de testimonios, samuel, etc.)
if (Test-Path "$BASE\img") {
    Get-ChildItem "$BASE\img" -Recurse -File | ForEach-Object {
        $rel = $_.FullName.Substring($BASE.Length + 1) -replace '\\','/'
        $fileMap += @{ local = $_.FullName; rel = $rel }
    }
}

# Subcarpetas con index.html — AUTODESCUBIERTAS (destinos + calculadora, comparador, etc.)
# Lista fija NO: ya costo que /calculadora/ y /comparador/ estuvieran 404 en produccion.
Get-ChildItem $BASE -Directory | Where-Object {
    $_.Name -notmatch '^(blog|js|img|node_modules|_reel_src|\.)' -and (Test-Path (Join-Path $_.FullName 'index.html'))
} | ForEach-Object {
    $fileMap += @{ local = (Join-Path $_.FullName 'index.html'); rel = ($_.Name + "/index.html") }
}

# Guard anti-duplicados: dejar solo una entrada por ruta
$fileMap = $fileMap | Group-Object { $_.rel } | ForEach-Object { $_.Group[0] }

Write-Host ("Total files: " + $fileMap.Count)

$deployFiles = @()
foreach ($f in $fileMap) {
    $bytes = [System.IO.File]::ReadAllBytes($f.local)
    $sha1  = [System.BitConverter]::ToString((New-Object System.Security.Cryptography.SHA1CryptoServiceProvider).ComputeHash($bytes)).Replace("-","").ToLower()
    $size  = $bytes.Length

    $uploadHeaders = @{
        Authorization     = "Bearer $TOKEN"
        "x-vercel-digest" = $sha1
        "Content-Type"    = "application/octet-stream"
    }
    try {
        $r = Invoke-WebRequest -Uri "https://api.vercel.com/v2/files?teamId=$TEAM" -Method POST -Headers $uploadHeaders -Body $bytes -UseBasicParsing -ErrorAction Stop
        Write-Host ("[" + $r.StatusCode + "] " + $f.rel)
    } catch {
        $code = $_.Exception.Response.StatusCode.value__
        Write-Host ("[" + $code + "] " + $f.rel)
    }
    $deployFiles += @{ file = $f.rel; sha = $sha1; size = $size }
}

Write-Host "Creating deployment..."
$body = @{ name="navia-website"; target="production"; project=$PROJ; files=$deployFiles } | ConvertTo-Json -Depth 5
try {
    $dep = Invoke-RestMethod -Uri "https://api.vercel.com/v13/deployments?teamId=$TEAM&forceNew=1" -Method POST -Headers $headers -Body $body -ErrorAction Stop
} catch {
    Write-Host ("CREATE ERROR: " + $_.Exception.Message)
    Write-Host ("DETAIL: " + $_.ErrorDetails.Message)
    exit 1
}
$id   = $dep.id
Write-Host ("Deployment ID: " + $id)
Write-Host ("URL: https://" + $dep.url)

# Poll de estado (no fatal — si la API falla no bloquea el aliasing)
$waited = 0; $ready = $false
do {
    Start-Sleep -Seconds 5; $waited += 5
    try {
        $s = Invoke-RestMethod -Uri ("https://api.vercel.com/v13/deployments/" + $id + "?teamId=" + $TEAM) -Headers $headers -ErrorAction Stop
        Write-Host ("  " + $s.readyState + " (" + $waited + "s)")
        if ($s.readyState -eq "READY") { $ready = $true }
        if ($s.readyState -in @("ERROR","CANCELED")) { break }
    } catch {
        Write-Host ("  (poll fallo, reintentando) " + $waited + "s")
    }
} while (-not $ready -and $waited -lt 120)

# Aliasing SIEMPRE (Vercel sirve el alias en cuanto el deployment queda READY)
Write-Host ("LIVE: https://" + $dep.url)
$aliasBody = @{ alias = "naviaglobal.co" } | ConvertTo-Json
try {
    $a = Invoke-RestMethod -Uri ("https://api.vercel.com/v2/deployments/" + $id + "/aliases?teamId=" + $TEAM) -Method POST -Headers $headers -Body $aliasBody
    Write-Host ("Alias: " + $a.alias)
} catch { Write-Host ("Alias ERROR: " + $_.Exception.Message) }
