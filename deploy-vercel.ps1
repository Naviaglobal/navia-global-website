$enc = New-Object System.Text.UTF8Encoding($false)
$TOKEN = [Environment]::GetEnvironmentVariable('VERCEL_TOKEN','User'); if (-not $TOKEN) { throw "Falta la variable de entorno VERCEL_TOKEN" }
$TEAM  = "team_XYsFDYqhJk3U1rmm9ejyhvnY"
$PROJ  = "prj_TEPIShAf5oL9DXIkNEv7bhxsO8aC"
$BASE  = "C:\Users\User\.claude\navia-website"

$headers = @{ Authorization = "Bearer $TOKEN"; "Content-Type" = "application/json" }

# Collect all files
$allFiles = @()
$allFiles += Get-ChildItem "$BASE\blog" -Filter "*.html"
$allFiles += Get-Item "$BASE\index.html" -ErrorAction SilentlyContinue

Write-Host ("Total files to deploy: " + $allFiles.Count)

$deployFiles = @()

foreach ($f in $allFiles) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $sha1 = [System.BitConverter]::ToString((New-Object System.Security.Cryptography.SHA1CryptoServiceProvider).ComputeHash($bytes)).Replace("-","").ToLower()
    $size = $bytes.Length

    # Determine relative path for Vercel
    if ($f.DirectoryName -like "*\blog") {
        $relPath = "blog/" + $f.Name
    } else {
        $relPath = $f.Name
    }

    # Upload file
    $uploadHeaders = @{
        Authorization    = "Bearer $TOKEN"
        "x-vercel-digest" = $sha1
        "Content-Type"   = "application/octet-stream"
    }
    try {
        $resp = Invoke-WebRequest -Uri "https://api.vercel.com/v2/files?teamId=$TEAM" -Method POST -Headers $uploadHeaders -Body $bytes -UseBasicParsing -ErrorAction SilentlyContinue
        Write-Host ("Uploaded [$($resp.StatusCode)]: " + $relPath)
    } catch {
        $code = $_.Exception.Response.StatusCode.value__
        if ($code -eq 200 -or $code -eq 201 -or $code -eq 409) {
            Write-Host ("Uploaded (already exists): " + $relPath)
        } else {
            Write-Host ("Upload ERROR " + $code + ": " + $relPath)
        }
    }

    $deployFiles += @{ file = $relPath; sha = $sha1; size = $size }
}

Write-Host "All files uploaded. Creating deployment..."

$deployBody = @{
    name    = "navia-website"
    target  = "production"
    project = $PROJ
    files   = $deployFiles
} | ConvertTo-Json -Depth 5

$deployResp = Invoke-RestMethod -Uri "https://api.vercel.com/v13/deployments?teamId=$TEAM" -Method POST -Headers $headers -Body $deployBody -UseBasicParsing
$deployId = $deployResp.id
$deployUrl = $deployResp.url
Write-Host ("Deployment created: " + $deployId)
Write-Host ("URL: https://" + $deployUrl)

# Wait for ready
Write-Host "Waiting for deployment to be ready..."
$maxWait = 120
$waited = 0
do {
    Start-Sleep -Seconds 5
    $waited += 5
    $status = Invoke-RestMethod -Uri "https://api.vercel.com/v13/deployments/$deployId`?teamId=$TEAM" -Headers $headers
    Write-Host ("  Status: " + $status.readyState + " (" + $waited + "s)")
} while ($status.readyState -notin @("READY","ERROR","CANCELED") -and $waited -lt $maxWait)

if ($status.readyState -eq "READY") {
    Write-Host ("DEPLOYED: https://" + $deployUrl)
    # Set alias
    $aliasBody = @{ alias = "naviaglobal.co" } | ConvertTo-Json
    try {
        $aliasResp = Invoke-RestMethod -Uri "https://api.vercel.com/v2/deployments/$deployId/aliases?teamId=$TEAM" -Method POST -Headers $headers -Body $aliasBody
        Write-Host ("Alias set: " + $aliasResp.alias)
    } catch {
        Write-Host ("Alias note: " + $_.Exception.Message)
    }
} else {
    Write-Host ("Deployment ended with state: " + $status.readyState)
}
