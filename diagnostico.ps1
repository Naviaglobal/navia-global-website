$dir = 'C:\Users\User\.claude\navia-website'

function Check-File($label, $path) {
    $c = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    Write-Host "=== $label ==="

    # Viewport
    $vp = [regex]::IsMatch($c, 'name="viewport"')
    Write-Host "  Viewport meta: $vp"

    # Canonical
    $canon = [regex]::Match($c, 'rel="canonical"\s+href="([^"]+)"')
    if($canon.Success) { Write-Host "  Canonical: " $canon.Groups[1].Value } else { Write-Host "  Canonical: FALTA" }

    # H1
    $h1 = [regex]::Matches($c, '<h1[^>]*>([^<]{1,60})')
    Write-Host "  H1 count: $($h1.Count)"
    if($h1.Count -gt 0) { Write-Host "  H1 texto: $($h1[0].Groups[1].Value.Trim())" }

    # OG tags
    $og = [regex]::Matches($c, 'property="og:')
    Write-Host "  OG tags: $($og.Count)"

    # Media queries
    $mq = [regex]::Matches($c, '@media\s*\(max-width')
    Write-Host "  Media queries mobile: $($mq.Count)"

    # Imgs sin lazy
    $imgs = [regex]::Matches($c, '<img [^>]+>')
    $lazy = $imgs | Where-Object { $_.Value -match 'loading=' }
    Write-Host "  Imgs: $($imgs.Count) total, $($lazy.Count) con lazy, $($imgs.Count - $lazy.Count) SIN lazy"

    # Schema
    $schemas = [regex]::Matches($c, '"@type"\s*:\s*"([^"]+)"')
    $schemaTypes = ($schemas | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique) -join ', '
    Write-Host "  Schemas: $schemaTypes"

    # Pixel
    $pixel = [regex]::Match($c, "fbq\('init','(\d+)'\)")
    if($pixel.Success) { Write-Host "  Pixel ID: $($pixel.Groups[1].Value)" } else { Write-Host "  Pixel: no encontrado en init" }

    # Formulario
    $form = [regex]::IsMatch($c, 'leadFormLanding|contactForm')
    Write-Host "  Formulario lead: $form"

    # Mobile nav
    $mobileNav = [regex]::IsMatch($c, 'hamburger|mobile-menu|nav-toggle|menu-btn')
    Write-Host "  Nav mobile hamburger: $mobileNav"

    # WhatsApp float
    $wa = [regex]::IsMatch($c, 'whatsapp-float')
    Write-Host "  WhatsApp float btn: $wa"

    Write-Host ""
}

Check-File "HOMEPAGE" "$dir\index.html"
Check-File "LANDING AUSTRALIA" "$dir\australia\index.html"
Check-File "LANDING IRLANDA" "$dir\irlanda\index.html"
Check-File "BLOG INDEX" "$dir\blog\index.html"
Check-File "ARTICULO BLOG" "$dir\blog\working-holiday-visa-colombia.html"

# Extra: verificar gracias.html
Write-Host "=== GRACIAS.HTML ==="
$gPath = "$dir\gracias.html"
if(Test-Path $gPath) {
    Write-Host "  Existe: SI"
} else {
    Write-Host "  Existe: NO — FALTA (redirect post-formulario apunta aqui)"
}

# Duplicados en raiz
Write-Host ""
Write-Host "=== ARCHIVOS HUERFANOS EN RAIZ ==="
@('estudiar-alemania-colombia-2026.html','estudiar-francia-colombia-2026.html') | ForEach-Object {
    $p = "$dir\$_"
    if(Test-Path $p) { Write-Host "  HUERFANO: /$_ (duplicado de /blog/$_)" }
}

# Sitemap stats
Write-Host ""
Write-Host "=== SITEMAP ==="
$sm = [System.IO.File]::ReadAllText("$dir\sitemap.xml", [System.Text.Encoding]::UTF8)
$urls = [regex]::Matches($sm, '<loc>')
Write-Host "  Total URLs: $($urls.Count)"
$p08 = [regex]::Matches($sm, 'priority>0\.8')
$p07 = [regex]::Matches($sm, 'priority>0\.7')
$p06 = [regex]::Matches($sm, 'priority>0\.6')
Write-Host "  Priority 0.8+: $($p08.Count)"
Write-Host "  Priority 0.7: $($p07.Count)"
Write-Host "  Priority 0.6: $($p06.Count)"
$lastmod = [regex]::Matches($sm, '<lastmod>2026')
Write-Host "  Con lastmod 2026: $($lastmod.Count)"
