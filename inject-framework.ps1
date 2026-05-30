$enc = New-Object System.Text.UTF8Encoding($false)
$base = 'C:\Users\User\.claude\navia-website\blog'

# Read HTML blocks from temp files
$eeat    = [System.IO.File]::ReadAllText('C:\Users\User\.claude\navia-website\tpl-eeat.html',    $enc)
$ctaMid  = [System.IO.File]::ReadAllText('C:\Users\User\.claude\navia-website\tpl-cta.html',     $enc)
$closing = [System.IO.File]::ReadAllText('C:\Users\User\.claude\navia-website\tpl-closing.html', $enc)

$files = Get-ChildItem $base -Filter '*.html' | Where-Object { $_.Name -ne 'index.html' }
$ok = 0; $skip = 0

foreach ($f in $files) {
    $c = [System.IO.File]::ReadAllText($f.FullName)
    if ($c.Contains('108268')) { $skip++; continue }

    # 1. EEAT: inject after first container/main/article opening tag
    $anchors = @('<div class="container">', '<main ', '<article ')
    foreach ($anchor in $anchors) {
        $idx = $c.IndexOf($anchor)
        if ($idx -gt 0) {
            $endTag = $c.IndexOf('>', $idx) + 1
            $c = $c.Substring(0, $endTag) + "`n" + $eeat + "`n" + $c.Substring($endTag)
            break
        }
    }

    # 2. Mid CTA: inject after </h2> nearest to 50% of doc
    $mid = [int]($c.Length * 0.50)
    $h2Pos = $c.IndexOf('</h2>', $mid)
    if ($h2Pos -gt 0) {
        $c = $c.Substring(0, $h2Pos + 5) + "`n" + $ctaMid + "`n" + $c.Substring($h2Pos + 5)
    }

    # 3. Closing: inject before </body>
    $bodyClose = $c.LastIndexOf('</body>')
    if ($bodyClose -gt 0) {
        $c = $c.Substring(0, $bodyClose) + $closing + "`n" + $c.Substring($bodyClose)
    }

    [System.IO.File]::WriteAllText($f.FullName, $c, $enc)
    $ok++
}

Write-Host ("DONE - Injected: " + $ok + " | Already done: " + $skip)
