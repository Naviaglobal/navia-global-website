$enc = New-Object System.Text.UTF8Encoding($false)
$blogDir = "C:\Users\User\.claude\navia-website\blog"
$today = "2026-05-12"
$a = [char]225; $e = [char]233; $i = [char]237; $o = [char]243; $u = [char]250

# Author schema: Organization → Person (Samuel Sanchez)
$oldAuthor = '"author": {
"@type": "Organization",
"name": "Navia Global"
}'

$newAuthor = '"author": {
"@type": "Person",
"name": "Samuel S' + $a + 'nchez",
"url": "https://naviaglobal.co/sobre-samuel-sanchez.html",
"jobTitle": "Fundador Navia Global",
"sameAs": [
"https://naviaglobal.co/sobre-samuel-sanchez.html"
]
}'

$fixed = 0
$lazyAdded = 0

Get-ChildItem $blogDir -Filter "*.html" | Where-Object { $_.Name -ne "index.html" } | ForEach-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
    $changed = $false

    # ── 1. Fix author schema ─────────────────────────────────────────────
    if ($content -like '*"@type": "Organization"*"name": "Navia Global"*') {
        # Patron minificado (una linea)
        $content = $content.Replace(
            '"author":{"@type":"Organization","name":"Navia Global"}',
            '"author":{"@type":"Person","name":"Samuel S' + $a + 'nchez","url":"https://naviaglobal.co/sobre-samuel-sanchez.html","jobTitle":"Fundador Navia Global","sameAs":["https://naviaglobal.co/sobre-samuel-sanchez.html"]}'
        )
        # Patron con saltos de linea
        $content = $content.Replace($oldAuthor, $newAuthor)
        $changed = $true
    }

    # ── 2. Update dateModified ────────────────────────────────────────────
    $content = [regex]::Replace($content, '"dateModified": "20\d\d-\d\d-\d\d"', '"dateModified": "' + $today + '"')
    $content = [regex]::Replace($content, '"dateModified":"20\d\d-\d\d-\d\d"', '"dateModified":"' + $today + '"')
    $changed = $true

    # ── 3. Add loading=lazy to images without it ──────────────────────────
    # Solo imagenes que NO sean LCP hero (primeras en el head, preload)
    # Agregar lazy a img tags que no tengan loading= ya
    $before = $content.Length
    $content = [regex]::Replace($content, '<img(?![^>]*loading=)([^>]*src="https://images\.unsplash\.com[^"]*"[^>]*)>', '<img loading="lazy"$1>')
    if ($content.Length -ne $before) {
        $lazyAdded++
        $changed = $true
    }

    if ($changed) {
        [System.IO.File]::WriteAllText($_.FullName, $content, $enc)
        $fixed++
    }
}

Write-Host "[OK] $fixed articulos actualizados"
Write-Host "[OK] loading=lazy agregado en $lazyAdded archivos adicionales"

# ── 4. Update sitemap lastmod ─────────────────────────────────────────────
$sitemapPath = "C:\Users\User\.claude\navia-website\sitemap.xml"
$sitemap = [System.IO.File]::ReadAllText($sitemapPath, [System.Text.Encoding]::UTF8)

# Actualizar todas las fechas de articulos de blog (no las legales)
$sitemap = [regex]::Replace($sitemap, '(<loc>https://naviaglobal\.co/blog/[^<]+</loc>\s*<lastmod>)20\d\d-\d\d-\d\d(</lastmod>)', '${1}' + $today + '${2}')
$sitemap = [regex]::Replace($sitemap, '(<loc>https://naviaglobal\.co/</loc>\s*<lastmod>)20\d\d-\d\d-\d\d(</lastmod>)', '${1}' + $today + '${2}')
$sitemap = [regex]::Replace($sitemap, '(<loc>https://naviaglobal\.co/sobre[^<]+</loc>\s*<lastmod>)20\d\d-\d\d-\d\d(</lastmod>)', '${1}' + $today + '${2}')

[System.IO.File]::WriteAllText($sitemapPath, $sitemap, $enc)
Write-Host "[OK] Sitemap lastmod actualizado a $today"

# ── 5. FAQ + EducationalOrganization schema en index.html ────────────────
$idxPath = "C:\Users\User\.claude\navia-website\index.html"
$idx = [System.IO.File]::ReadAllText($idxPath, [System.Text.Encoding]::UTF8)

# 5a. Agregar EducationalOrganization al tipo del LocalBusiness schema
$idx = $idx.Replace(
    '"@type": "LocalBusiness"',
    '"@type": ["LocalBusiness", "EducationalOrganization"]'
)
# Version minificada
$idx = $idx.Replace(
    '"@type":"LocalBusiness"',
    '"@type":["LocalBusiness","EducationalOrganization"]'
)

# 5b. Agregar FAQ schema justo antes del </head>
$faqSchema = '<script type="application/ld+json">{"@context":"https://schema.org","@type":"FAQPage","mainEntity":[{"@type":"Question","name":"' + [char]191 + 'Cu' + $a + 'nto cuesta estudiar en el exterior desde Colombia?","acceptedAnswer":{"@type":"Answer","text":"Los costos var' + $i + 'an seg' + [char]250 + 'n el pa' + $i + 's: Australia desde AUD $6,000 por 6 meses, Irlanda desde EUR 3,000 por 25 semanas, Canad' + $a + ' desde CAD $4,000. Navia Global asesora sin costo adicional."}},{"@type":"Question","name":"' + [char]191 + 'Cu' + $a + 'les son los requisitos para estudiar en el exterior siendo colombiano?","acceptedAnswer":{"@type":"Answer","text":"Los requisitos principales son: pasaporte vigente, prueba de solvencia econ' + [char]243 + 'mica, admisi' + [char]243 + 'n de la escuela de idiomas y solicitud de visa. No se requiere IELTS para cursos de ingl' + $e + 's general."}},{"@type":"Question","name":"' + [char]191 + 'Se puede trabajar mientras se estudia en el exterior?","acceptedAnswer":{"@type":"Answer","text":"S' + $i + '. Australia permite 24h/semana, Ir landa 20h/semana, Canad' + $a + ' 20h/semana, Reino Unido 20h/semana. Dubai y Estados Unidos tienen restricciones seg' + $u + 'n el tipo de visa."}},{"@type":"Question","name":"' + [char]191 + 'Navia Global cobra por la asesor' + $i + 'a?","acceptedAnswer":{"@type":"Answer","text":"No. La asesor' + $i + 'a de Navia Global es completamente gratuita para el estudiante. Los ingresos vienen de las escuelas de idiomas asociadas, no del estudiante."}}]}</script>'

if ($idx -notlike '*FAQPage*') {
    $idx = $idx.Replace('</head>', $faqSchema + '</head>')
    Write-Host "[OK] FAQ schema agregado al index"
} else {
    Write-Host "[INFO] FAQ schema ya existe en index"
}

[System.IO.File]::WriteAllText($idxPath, $idx, $enc)
Write-Host "[OK] Index: EducationalOrganization + FAQ schema aplicados"
