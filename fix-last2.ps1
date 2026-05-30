$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
$o = [char]243
$i = [char]237
$html = $html.Replace('Duraci' + [char]195 + [char]179 + 'n', 'Duraci' + $o + 'n')
$html = $html.Replace('matr' + [char]195 + [char]173 + 'cula', 'matr' + $i + 'cula')
[System.IO.File]::WriteAllText($path, $html, $enc)
Write-Host "[OK] Duracion y matricula corregidos"
