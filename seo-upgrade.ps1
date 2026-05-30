$enc = New-Object System.Text.UTF8Encoding($false)
$blogDir = "C:\Users\User\.claude\navia-website\blog"
$articles = Get-ChildItem $blogDir -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }

$processed = 0
$skipped   = 0

foreach ($file in $articles) {
    $html = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    # ── 1. Extract metadata ───────────────────────────────────
    $canonical = ""
    if ($html -match '<link rel="canonical" href="([^"]+)"') { $canonical = $matches[1] }

    $pageTitle = ""
    if ($html -match '<title>([^<]+)</title>') { $pageTitle = $matches[1] }
    $shortTitle = $pageTitle -replace '\s*\|\s*Navia Global.*$', ''
    if ($shortTitle.Length -gt 55) { $shortTitle = $shortTitle.Substring(0,52) + "..." }

    $h1Text = ""
    if ($html -match '<h1[^>]*>([^<]+)</h1>') { $h1Text = $matches[1].Trim() }

    # ── 2. FAQ extraction ─────────────────────────────────────
    $faqItems = @()
    $faqPattern = '(?s)<div class="faq-item">\s*<h3>([^<]+)</h3>\s*<p>(.*?)</p>'
    $faqMatches = [regex]::Matches($html, $faqPattern)
    foreach ($m in $faqMatches) {
        $q = $m.Groups[1].Value.Trim()
        $a = ($m.Groups[2].Value -replace '<[^>]+>', '').Trim()
        # Escape for JSON
        $q = $q -replace '\\', '\\' -replace '"', '\"'
        $a = $a -replace '\\', '\\' -replace '"', '\"'
        if ($q -and $a) { $faqItems += @{ q = $q; a = $a } }
    }

    # ── 3. Build schemas ──────────────────────────────────────
    $schemasToAdd = ""

    # 3a. BreadcrumbList (only if not already present)
    if ($html -notlike "*BreadcrumbList*") {
        $bc  = "`n    <script type=`"application/ld+json`">`n"
        $bc += "    {`n"
        $bc += "      `"@context`": `"https://schema.org`",`n"
        $bc += "      `"@type`": `"BreadcrumbList`",`n"
        $bc += "      `"itemListElement`": [`n"
        $bc += "        {`"@type`":`"ListItem`",`"position`":1,`"name`":`"Inicio`",`"item`":`"https://naviaglobal.co`"},`n"
        $bc += "        {`"@type`":`"ListItem`",`"position`":2,`"name`":`"Blog`",`"item`":`"https://naviaglobal.co/blog/`"},`n"
        $bc += "        {`"@type`":`"ListItem`",`"position`":3,`"name`":`"$shortTitle`",`"item`":`"$canonical`"}`n"
        $bc += "      ]`n"
        $bc += "    }`n"
        $bc += "    </script>"
        $schemasToAdd += $bc
    }

    # 3b. FAQPage schema (only if FAQ found and not already present)
    if ($faqItems.Count -gt 0 -and $html -notlike "*FAQPage*") {
        $faq  = "`n    <script type=`"application/ld+json`">`n"
        $faq += "    {`n"
        $faq += "      `"@context`": `"https://schema.org`",`n"
        $faq += "      `"@type`": `"FAQPage`",`n"
        $faq += "      `"mainEntity`": [`n"
        $entities = @()
        foreach ($item in $faqItems) {
            $e  = "        {`n"
            $e += "          `"@type`": `"Question`",`n"
            $e += "          `"name`": `"$($item.q)`",`n"
            $e += "          `"acceptedAnswer`": {`"@type`":`"Answer`",`"text`":`"$($item.a)`"}`n"
            $e += "        }"
            $entities += $e
        }
        $faq += ($entities -join ",`n")
        $faq += "`n      ]`n"
        $faq += "    }`n"
        $faq += "    </script>"
        $schemasToAdd += $faq
    }

    # Inject schemas before </head>
    if ($schemasToAdd -ne "") {
        $html = $html -replace '</head>', ($schemasToAdd + "`n</head>")
    }

    # ── 4. Breadcrumb nav HTML ────────────────────────────────
    if ($html -notlike "*blog-breadcrumb*") {
        $breadcrumbHtml = "    <nav class=`"blog-breadcrumb`" aria-label=`"Breadcrumb`" style=`"background:rgba(11,44,74,0.97);padding:8px 0;`"><div style=`"max-width:1200px;margin:0 auto;padding:0 20px;font-size:0.8rem;color:rgba(255,255,255,0.72);`"><a href=`"/`" style=`"color:rgba(255,255,255,0.72);text-decoration:none;`">Inicio</a> <span style=`"margin:0 6px;opacity:.5;`">/</span> <a href=`"/blog/`" style=`"color:rgba(255,255,255,0.72);text-decoration:none;`">Blog</a> <span style=`"margin:0 6px;opacity:.5;`">/</span> <span style=`"color:white;`">$shortTitle</span></div></nav>"
        $html = $html -replace '(</header>)', ("`$1`n" + $breadcrumbHtml)
    }

    # ── 5. Sticky mobile CTA ──────────────────────────────────
    if ($html -notlike "*mobile-sticky-cta*") {
        # Detect country for WhatsApp message
        $waMsgCountry = "el exterior"
        $fname = $file.Name.ToLower()
        if ($fname -like "*australia*") { $waMsgCountry = "Australia" }
        elseif ($fname -like "*irlanda*" -or $fname -like "*dublin*" -or $fname -like "*cork*") { $waMsgCountry = "Irlanda" }
        elseif ($fname -like "*canada*" -or $fname -like "*toronto*" -or $fname -like "*vancouver*") { $waMsgCountry = "Canad%C3%A1" }
        elseif ($fname -like "*reino-unido*" -or $fname -like "*londres*" -or $fname -like "*manchester*") { $waMsgCountry = "Reino%20Unido" }
        elseif ($fname -like "*nueva-zelanda*" -or $fname -like "*auckland*") { $waMsgCountry = "Nueva%20Zelanda" }
        elseif ($fname -like "*malta*") { $waMsgCountry = "Malta" }
        elseif ($fname -like "*dubai*") { $waMsgCountry = "D%C3%BAbai" }
        elseif ($fname -like "*estados-unidos*" -or $fname -like "*nueva-york*" -or $fname -like "*miami*") { $waMsgCountry = "Estados%20Unidos" }
        elseif ($fname -like "*alemania*") { $waMsgCountry = "Alemania" }
        elseif ($fname -like "*francia*") { $waMsgCountry = "Francia" }

        $waUrl = "https://wa.me/573014430722?text=Hola%2C%20quiero%20informaci%C3%B3n%20sobre%20estudiar%20en%20$waMsgCountry"

        $stickyCss = @"
    <style>
    #mobile-sticky-cta{display:none;position:fixed;bottom:0;left:0;right:0;z-index:9990;background:linear-gradient(90deg,#1B4B8C,#1e6b5e);padding:13px 20px;text-align:center;box-shadow:0 -3px 20px rgba(0,0,0,0.18);}
    #mobile-sticky-cta a{color:white;text-decoration:none;font-weight:800;font-size:1rem;display:flex;align-items:center;justify-content:center;gap:10px;}
    #mobile-sticky-cta a span.pill{background:#32B298;color:white;padding:4px 14px;border-radius:20px;font-size:0.85rem;font-weight:700;}
    @media(max-width:768px){#mobile-sticky-cta{display:block;}#back-to-top{bottom:72px!important;}.whatsapp-float{bottom:72px!important;}}
    </style>
"@

        $stickyHtml = @"
    <div id="mobile-sticky-cta">
      <a href="$waUrl" target="_blank" rel="noopener">
        <span class="pill">Gratis</span>
        Asesoría para estudiar en $($waMsgCountry -replace '%[0-9A-F]{2}','') &#8594;
      </a>
    </div>
"@

        $html = $html -replace '(<style>)', ($stickyCss + '$1')
        $html = $html -replace '</body>', ($stickyHtml + "`n</body>")
    }

    # ── 6. Update visible date if still says 2025 ────────────
    $html = $html -replace 'Actualizado:\s*Diciembre 2025', 'Actualizado: Abril 2026'
    $html = $html -replace 'Actualizado:\s*Enero 2026', 'Actualizado: Abril 2026'
    $html = $html -replace 'Actualizado:\s*Febrero 2026', 'Actualizado: Abril 2026'
    $html = $html -replace 'actualizado\s+abril 2026', 'actualizado mayo 2026'

    # Write back
    [System.IO.File]::WriteAllText($file.FullName, $html, $enc)
    $processed++
    Write-Host ("[OK] " + $file.Name)
}

Write-Host ("`nDone: $processed articles upgraded, $skipped skipped")
