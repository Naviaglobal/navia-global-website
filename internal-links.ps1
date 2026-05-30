$enc = New-Object System.Text.UTF8Encoding($false)
$blogDir = "C:\Users\User\.claude\navia-website\blog"

# Keyword -> URL mapping (keyword as it appears in text -> relative URL)
$linkMap = [ordered]@{
    "Subclase 500"                  = "/blog/visa-estudiante-australia-2026.html"
    "subcl. 500"                    = "/blog/visa-estudiante-australia-2026.html"
    "Stamp 2"                       = "/blog/visa-estudiante-irlanda-colombia-2026.html"
    "Study Permit"                  = "/blog/visa-estudiante-canada-2026.html"
    "visa F-1"                      = "/blog/visa-estudiante-estados-unidos-colombia-2026.html"
    "PGWP"                          = "/blog/visa-estudiante-canada-2026.html"
    "Graduate Route"                = "/blog/visa-estudiante-reino-unido-colombia-2026.html"
    "visa Schengen"                 = "/blog/visa-schengen-colombianos-2026.html"
    "IELTS"                         = "/blog/diferencia-ielts-toefl-colombia.html"
    "TOEFL"                         = "/blog/diferencia-ielts-toefl-colombia.html"
    "trabajar mientras estudias"    = "/blog/trabajar-mientras-estudias-exterior.html"
    "trabajar mientras estudiaba"   = "/blog/trabajar-mientras-estudias-exterior.html"
    "nivel B2"                      = "/blog/ingles-b2-cuanto-tiempo-colombia.html"
    "ingles B2"                     = "/blog/ingles-b2-cuanto-tiempo-colombia.html"
    "Sydney"                        = "/blog/estudiar-ingles-sydney-colombia.html"
    "Melbourne"                     = "/blog/estudiar-ingles-melbourne-colombia.html"
    "Toronto"                       = "/blog/estudiar-ingles-toronto-colombia.html"
    "Vancouver"                     = "/blog/estudiar-ingles-vancouver-colombia.html"
    "Dublin"                        = "/blog/estudiar-ingles-dublin-colombia.html"
    "Cork"                          = "/blog/estudiar-ingles-cork-colombia.html"
    "Auckland"                      = "/blog/estudiar-ingles-auckland-colombia.html"
    "Londres"                       = "/blog/estudiar-ingles-londres-colombia.html"
    "Manchester"                    = "/blog/estudiar-ingles-manchester-colombia.html"
    "Nueva York"                    = "/blog/estudiar-ingles-nueva-york-colombia.html"
    "vivir y trabajar en Irlanda"   = "/blog/vivir-trabajar-irlanda-colombianos-2026.html"
    "elegir tu escuela"             = "/blog/como-elegir-escuela-idiomas-exterior.html"
    "como elegir una escuela"       = "/blog/como-elegir-escuela-idiomas-exterior.html"
    "alojamiento en el exterior"    = "/blog/alojamiento-estudiar-exterior-colombia.html"
    "tipos de alojamiento"          = "/blog/alojamiento-estudiar-exterior-colombia.html"
    "becas disponibles"             = "/blog/becas-estudiar-exterior-colombia-2026.html"
    "becas para colombianos"        = "/blog/becas-estudiar-exterior-colombia-2026.html"
    "maestrias en el exterior"      = "/blog/maestrias-exterior-colombia-2026.html"
    "estudiar sin dinero"           = "/blog/estudiar-exterior-sin-dinero-colombia-2026.html"
    "conseguir trabajo"             = "/blog/como-conseguir-trabajo-extranjero-colombia.html"
}

function Add-ContextualLink($html, $keyword, $url) {
    $escaped = [regex]::Escape($keyword)
    $pattern = "(?i)\b$escaped\b"
    $ms = [regex]::Matches($html, $pattern)
    foreach ($m in $ms) {
        $pos = $m.Index
        # Check ~300 chars before for open <a that hasn't closed yet
        $start = [Math]::Max(0, $pos - 300)
        $before = $html.Substring($start, $pos - $start)
        $lastOpen  = $before.LastIndexOf('<a ')
        $lastClose = $before.LastIndexOf('</a>')
        if ($lastOpen -gt $lastClose) { return $html }  # inside <a>, skip

        # Check we're inside a <p> (not in heading, script, style)
        $tagsBefore = [regex]::Matches($before, '<(p|h[1-6]|script|style|title)[^/]')
        $lastTag = if ($tagsBefore.Count -gt 0) { $tagsBefore[$tagsBefore.Count-1].Value } else { "" }
        if ($lastTag -match '<(script|style|title|h[1-6])') { return $html }

        # Replace only this specific occurrence
        $linkHtml = '<a href="' + $url + '" style="color:#1B4B8C;font-weight:600;">' + $m.Value + '</a>'
        $html = $html.Substring(0, $pos) + $linkHtml + $html.Substring($pos + $m.Length)
        return $html  # only first occurrence
    }
    return $html
}

$articles = Get-ChildItem $blogDir -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }
$totalLinks = 0

foreach ($file in $articles) {
    $html = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $linksAdded = 0

    foreach ($kv in $linkMap.GetEnumerator()) {
        $keyword = $kv.Key
        $url     = $kv.Value
        $fname   = "/blog/" + $file.Name

        # Don't link article to itself
        if ($fname -eq $url) { continue }
        # Don't add if URL already linked in this article
        if ($html -like ("*href=`"" + $url + "`"*")) { continue }

        $newHtml = Add-ContextualLink $html $keyword $url
        if ($newHtml -ne $html) {
            $html = $newHtml
            $linksAdded++
        }
    }

    if ($linksAdded -gt 0) {
        [System.IO.File]::WriteAllText($file.FullName, $html, $enc)
        $totalLinks += $linksAdded
        Write-Host ("[+$linksAdded] " + $file.Name)
    }
}

Write-Host ("`nTotal contextual links added: $totalLinks across " + $articles.Count + " articles")
