$enc = New-Object System.Text.UTF8Encoding($false)
$path = 'C:\Users\User\.claude\navia-website\blog\estudiar-nueva-zelanda-colombia-2026.html'
$c = [System.IO.File]::ReadAllText($path, $enc)
$c = [System.Text.RegularExpressions.Regex]::Replace($c, '<title>[^<]*</title>', '<title>Estudiar en Nueva Zelanda 2026: Trabaja 25h/semana Legalmente | Navia Global</title>')
$c = [System.Text.RegularExpressions.Regex]::Replace($c, '<meta\s+name="description"\s+content="[^"]*"[^>]*>', '<meta name="description" content="Visa NZD $850, salario NZD $23.15/h y costos reales de vida para estudiantes colombianos en Nueva Zelanda 2026.">')
[System.IO.File]::WriteAllText($path, $c, $enc)
Write-Host 'NZ title fixed'
