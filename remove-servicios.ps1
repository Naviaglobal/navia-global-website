$enc = New-Object System.Text.UTF8Encoding($false)
$file = 'C:\Users\User\.claude\navia-website\index.html'
$html = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Find the servicios section (has class before id)
$svcStart = $html.IndexOf('<section class="servicios" id="servicios"')
Write-Host ("servicios start: " + $svcStart)

if ($svcStart -ge 0) {
    # Walk forward tracking nested <section> depth to find closing </section>
    $pos = $svcStart + 10
    $depth = 1
    while ($pos -lt $html.Length -and $depth -gt 0) {
        $openIdx  = $html.IndexOf('<section', $pos)
        $closeIdx = $html.IndexOf('</section>', $pos)

        if ($closeIdx -lt 0) { Write-Host "ERROR: no closing tag found"; break }

        if ($openIdx -gt 0 -and $openIdx -lt $closeIdx) {
            # Found a nested <section> before the close
            $depth++
            $pos = $openIdx + 8
        } else {
            $depth--
            if ($depth -eq 0) {
                $svcEnd = $closeIdx + 10  # skip past </section>
                Write-Host ("servicios end: " + $svcEnd)
                Write-Host ("Removing " + ($svcEnd - $svcStart) + " chars")
                $html = $html.Substring(0, $svcStart) + $html.Substring($svcEnd)
                Write-Host "[OK] Seccion servicios eliminada"
                break
            }
            $pos = $closeIdx + 10
        }
    }
} else {
    Write-Host "[ERROR] No se encontro la seccion servicios"
}

# Save
[System.IO.File]::WriteAllText($file, $html, $enc)
Write-Host "[OK] Guardado"
Write-Host ("servicios section gone: " + (-not ($html -match 'id="servicios"')))
