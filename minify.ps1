$enc = New-Object System.Text.UTF8Encoding($false)
$baseDir = "C:\Users\User\.claude\navia-website"

function Minify-HTML($content) {
    # 1. Eliminar comentarios HTML
    $content = [regex]::Replace($content, '<!--(?!\[if).*?-->', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    # 2. Eliminar indentacion al inicio de cada linea
    $content = [regex]::Replace($content, '(?m)^\s+', '')
    # 3. Colapsar espacios multiples
    $content = [regex]::Replace($content, '[ \t]{2,}', ' ')
    # 4. Eliminar lineas vacias multiples
    $content = [regex]::Replace($content, '(\r?\n){2,}', "`n")
    # 5. Eliminar espacios entre tags HTML
    $content = [regex]::Replace($content, '>\s+<', '><')

    # 6. Comprimir CSS en <style>
    $content = [regex]::Replace($content, '(?s)(<style[^>]*>)(.*?)(</style>)', {
        param($m)
        $inner = $m.Groups[2].Value
        $inner = [regex]::Replace($inner, '/\*.*?\*/', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        $inner = [regex]::Replace($inner, '\s+', ' ')
        $inner = [regex]::Replace($inner, '\s*([:;{},>])\s*', '$1')
        $inner = $inner.Replace(';}', '}')
        $m.Groups[1].Value + $inner.Trim() + $m.Groups[3].Value
    })

    # 7. Comprimir JS en <script> inline
    $content = [regex]::Replace($content, '(?s)(<script(?![^>]*src)[^>]*>)(.*?)(</script>)', {
        param($m)
        $inner = $m.Groups[2].Value
        $inner = [regex]::Replace($inner, '//[^\n"''`]*\n', "`n")
        $inner = [regex]::Replace($inner, '/\*.*?\*/', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        $inner = [regex]::Replace($inner, '(\r?\n\s*){2,}', "`n")
        $inner = [regex]::Replace($inner, '[ \t]{2,}', ' ')
        $m.Groups[1].Value + "`n" + $inner.Trim() + "`n" + $m.Groups[3].Value
    })

    return $content.Trim()
}

$processed = 0
$totalSaved = 0

# Archivos raiz
$rootFiles = @("index.html","sobre-samuel-sanchez.html","terminos-y-condiciones.html","politica-de-cookies.html","politica-de-privacidad.html")
foreach ($f in $rootFiles) {
    $p = Join-Path $baseDir $f
    if (Test-Path $p) {
        $original = [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8)
        $minified = Minify-HTML $original
        $saved = $original.Length - $minified.Length
        [System.IO.File]::WriteAllText($p, $minified, $enc)
        $processed++
        $totalSaved += $saved
        $kb = [math]::Round($saved/1KB,1)
        Write-Host "[OK] $f ($kb KB saved)"
    }
}

# Blog articles
$blogDir = Join-Path $baseDir "blog"
Get-ChildItem $blogDir -Filter "*.html" | ForEach-Object {
    $original = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $minified = Minify-HTML $original
    $saved = $original.Length - $minified.Length
    [System.IO.File]::WriteAllText($_.FullName, $minified, $enc)
    $processed++
    $totalSaved += $saved
    $kb = [math]::Round($saved/1KB,1)
    $name = $_.Name
    Write-Host "[OK] blog/$name ($kb KB saved)"
}

$totalKB = [math]::Round($totalSaved/1KB,0)
Write-Host ""
Write-Host "Minificacion completada: $processed archivos, $totalKB KB eliminados"
