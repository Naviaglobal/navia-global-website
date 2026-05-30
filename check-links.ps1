$dir = 'C:\Users\User\.claude\navia-website'

# Archivos existentes
$existing = @{}
Get-ChildItem $dir -Recurse -Filter '*.html' | ForEach-Object {
    $rel = $_.FullName.Replace($dir, '').Replace('\', '/').ToLower()
    $existing[$rel] = $true
    # tambien sin /index.html
    if($rel -match '/index\.html$') {
        $withSlash = $rel -replace '/index\.html$', '/'
        $withoutSlash = $rel -replace '/index\.html$', ''
        $existing[$withSlash] = $true
        $existing[$withoutSlash] = $true
    }
}
# rutas especiales
$existing['/gracias.html'] = $true
$existing['/gracias/'] = $true

$files = Get-ChildItem $dir -Recurse -Filter '*.html' | Where-Object { $_.Name -notmatch '^tpl-' }

$brokenMap = @{}

foreach($file in $files) {
    $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $matches = [regex]::Matches($c, 'href="(/[^"#?]*)"')
    foreach($m in $matches) {
        $link = $m.Groups[1].Value.ToLower()
        # Solo links internos con .html o trailing slash
        if($link -match '\.(html|htm)$' -or $link -match '/$' -or $link -match '^/[a-z-]+$') {
            $check1 = $link
            $check2 = $link.TrimEnd('/') + '/index.html'
            $check3 = $link + '.html'
            $check4 = $link.TrimEnd('/')
            if(-not ($existing[$check1] -or $existing[$check2] -or $existing[$check3] -or $existing[$check4])) {
                if(-not $brokenMap[$link]) { $brokenMap[$link] = @() }
                $brokenMap[$link] += $file.Name
            }
        }
    }
}

Write-Host "=== ENLACES ROTOS ==="
if($brokenMap.Count -eq 0) {
    Write-Host "Ninguno encontrado"
} else {
    foreach($link in ($brokenMap.Keys | Sort-Object)) {
        $sources = ($brokenMap[$link] | Select-Object -Unique) -join ', '
        Write-Host "[ROTO] $link <- en: $sources"
    }
}
Write-Host ""
Write-Host "Total rutas rotas: $($brokenMap.Count)"
Write-Host "Total archivos HTML: $($files.Count)"
