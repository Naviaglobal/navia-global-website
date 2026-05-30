$enc = New-Object System.Text.UTF8Encoding($false)
$TOKEN = "vcp_1IB4w0E4SHS9iIkNztXKFmih2EVBR6gGSaBzU7mg3JIKU2NXmr29ShvJ"
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

# Root files
@("index.html","logo.webp","vercel.json","robots.txt","sitemap.xml",
  "sobre-samuel-sanchez.html",
  "terminos-y-condiciones.html","politica-de-cookies.html","politica-de-privacidad.html") | ForEach-Object {
    $p = Join-Path $BASE $_
    if (Test-Path $p) { $fileMap += @{ local = $p; rel = $_ } }
}

# JS folder
Get-ChildItem "$BASE\js" -ErrorAction SilentlyContinue | ForEach-Object {
    $fileMap += @{ local = $_.FullName; rel = "js/" + $_.Name }
}

# Destination landing pages + contacto
@("australia","irlanda","canada","malta","dubai","nueva-zelanda","reino-unido","estados-unidos","francia","alemania") | ForEach-Object {
    $p = Join-Path $BASE "$_\index.html"
    if (Test-Path $p) { $fileMap += @{ local = $p; rel = "$_/index.html" } }
}
$contacto = Join-Path $BASE "contacto.html"
if (Test-Path $contacto) { $fileMap += @{ local = $contacto; rel = "contacto.html" } }

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
$dep  = Invoke-RestMethod -Uri "https://api.vercel.com/v13/deployments?teamId=$TEAM" -Method POST -Headers $headers -Body $body
$id   = $dep.id
Write-Host ("Deployment ID: " + $id)
Write-Host ("URL: https://" + $dep.url)

$waited = 0
do {
    Start-Sleep -Seconds 5; $waited += 5
    $s = Invoke-RestMethod -Uri ("https://api.vercel.com/v13/deployments/" + $id + "?teamId=" + $TEAM) -Headers $headers
    Write-Host ("  " + $s.readyState + " (" + $waited + "s)")
} while ($s.readyState -notin @("READY","ERROR","CANCELED") -and $waited -lt 150)

if ($s.readyState -eq "READY") {
    Write-Host ("LIVE: https://" + $dep.url)
    $aliasBody = @{ alias = "naviaglobal.co" } | ConvertTo-Json
    try {
        $a = Invoke-RestMethod -Uri ("https://api.vercel.com/v2/deployments/" + $id + "/aliases?teamId=" + $TEAM) -Method POST -Headers $headers -Body $aliasBody
        Write-Host ("Alias: " + $a.alias)
    } catch { Write-Host ("Alias: " + $_.Exception.Message) }
} else {
    Write-Host ("Estado final: " + $s.readyState)
}
