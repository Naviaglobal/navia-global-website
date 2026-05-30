$enc = New-Object System.Text.UTF8Encoding($false)
$blogDir = "C:\Users\User\.claude\navia-website\blog"
$articles = Get-ChildItem $blogDir -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }

$processed = 0

foreach ($file in $articles) {
    $html = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $changed = $false

    # 1. Add preconnect + dns-prefetch for Unsplash and fonts after <head>
    if ($html -notlike "*preconnect*unsplash*") {
        $hints = @"
    <link rel="preconnect" href="https://images.unsplash.com">
    <link rel="dns-prefetch" href="https://images.unsplash.com">
    <link rel="preconnect" href="https://flagcdn.com">
    <link rel="preconnect" href="https://fonts.googleapis.com">
"@
        $html = $html -replace '(<link rel="canonical")', ($hints + "`n    `$1")
        $changed = $true
    }

    # 2. Add fetchpriority="high" + explicit width/height to hero image (first Unsplash img)
    # Pattern: <img src="https://images.unsplash.com/...hero-image...">
    if ($html -notlike '*fetchpriority="high"*') {
        # Hero image: class="hero-image" - add fetchpriority and explicit dimensions
        $html = $html -replace '(<img src="https://images\.unsplash\.com/[^"]+"\s+alt="[^"]*"\s+class="hero-image")',
            '$1 fetchpriority="high" width="1200" height="600"'
        # Also handle hero-image where class comes first
        $html = $html -replace '(<img [^>]*class="hero-image"[^>]*src="https://images\.unsplash\.com/[^"]*")',
            '$1 fetchpriority="high" width="1200" height="600"'
        $changed = $true
    }

    # 3. Add width/height to content-image and section-image to prevent CLS
    # content-image: 1200x600 (from URL parameters w=1200&h=600)
    $html = $html -replace '(<img src="https://images\.unsplash\.com/[^"]+"\s+alt="[^"]*"\s+class="content-image")(?!\s+width)',
        '$1 width="1200" height="600" loading="lazy"'
    $html = $html -replace '(<img src="https://images\.unsplash\.com/[^"]+"\s+alt="[^"]*"\s+class="section-image")(?!\s+width)',
        '$1 width="1200" height="600" loading="lazy"'

    # 4. Add max-image-preview meta for Google Discover eligibility
    if ($html -notlike '*max-image-preview*') {
        $html = $html -replace '(<meta name="author")',
            '<meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">' + "`n    `$1"
        $changed = $true
    }

    # 5. Add preload for hero image (first Unsplash image found)
    if ($html -notlike '*rel="preload"*as="image"*') {
        $heroMatch = [regex]::Match($html, 'src="(https://images\.unsplash\.com/[^"]+(?:hero|photo)[^"]*)"')
        if (-not $heroMatch.Success) {
            $heroMatch = [regex]::Match($html, 'property="og:image" content="([^"]+)"')
        }
        if ($heroMatch.Success) {
            $heroUrl = $heroMatch.Groups[1].Value
            $preloadTag = '    <link rel="preload" as="image" href="' + $heroUrl + '" fetchpriority="high">'
            $html = $html -replace '(<link rel="canonical")', ($preloadTag + "`n    `$1")
            $changed = $true
        }
    }

    if ($changed) {
        [System.IO.File]::WriteAllText($file.FullName, $html, $enc)
        $processed++
        Write-Host ("[OK] " + $file.Name)
    }
}

# Also fix homepage
$homePath = "C:\Users\User\.claude\navia-website\index.html"
$homeHtml = [System.IO.File]::ReadAllText($homePath, [System.Text.Encoding]::UTF8)
if ($homeHtml -notlike "*preconnect*unsplash*") {
    $hints = "    <link rel=`"preconnect`" href=`"https://images.unsplash.com`">`n    <link rel=`"dns-prefetch`" href=`"https://images.unsplash.com`">`n"
    $homeHtml = $homeHtml -replace '(<link rel="canonical")', ($hints + '    $1')
    [System.IO.File]::WriteAllText($homePath, $homeHtml, $enc)
    Write-Host "[OK] index.html (homepage)"
}

Write-Host ("`nCore Web Vitals fixes applied to $processed articles")
