$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# ── Fix destinoInfo nombres (emojis corruptos → nombres limpios) ──────────
$html = $html.Replace("nombre: 'Australia " + [char]0xD83C + [char]0xDDE6 + [char]0xD83C + [char]0xDDFA + "'", "nombre: 'Australia'")
$html = $html.Replace("nombre: 'Nueva Zelanda " + [char]0xD83C + [char]0xDDF3 + [char]0xD83C + [char]0xDDFF + "'", "nombre: 'Nueva Zelanda'")
$html = $html.Replace("nombre: 'Irlanda " + [char]0xD83C + [char]0xDDEE + [char]0xD83C + [char]0xDDEA + "'", "nombre: 'Irlanda'")
$html = $html.Replace("nombre: 'Malta " + [char]0xD83C + [char]0xDDF2 + [char]0xD83C + [char]0xDDF9 + "'", "nombre: 'Malta'")
$html = $html.Replace("nombre: 'Dubai " + [char]0xD83C + [char]0xDDE6 + [char]0xD83C + [char]0xDDEA + "'", "nombre: 'Dubai'")
$html = $html.Replace("nombre: 'Estados Unidos " + [char]0xD83C + [char]0xDDFA + [char]0xD83C + [char]0xDDF8 + "'", "nombre: 'Estados Unidos'")
$html = $html.Replace("nombre: 'Reino Unido " + [char]0xD83C + [char]0xDDEC + [char]0xD83C + [char]0xDDE7 + "'", "nombre: 'Reino Unido'")
$html = $html.Replace("nombre: 'Francia " + [char]0xD83C + [char]0xDDEB + [char]0xD83C + [char]0xDDF7 + "'", "nombre: 'Francia'")
$html = $html.Replace("nombre: 'Alemania " + [char]0xD83C + [char]0xDDE9 + [char]0xD83C + [char]0xDDEA + "'", "nombre: 'Alemania'")

# Canada con emoji y acento corrupto → Canadá limpio
$html = [regex]::Replace($html, "nombre: 'Canad[^']*'(?=, moneda: 'CAD')", "nombre: 'Canad" + [char]225 + "'")

# ── Fix strings garbled: secuencias UTF-8 mal interpretadas ──────────────
# ÃÂ¡ → á, Ã³ → ó, Ã­ → í, Ã© → é, Ã± → ñ
$html = $html.Replace('CanadÃ¡', 'Canad' + [char]225)
$html = $html.Replace('DuraciÃ³n', 'Duraci' + [char]243 + 'n')
$html = $html.Replace('matrÃ­cula', 'matr' + [char]237 + 'cula')
$html = $html.Replace('CÃ¡lido', 'C' + [char]225 + 'lido')
$html = $html.Replace('InglÃ©s', 'Ingl' + [char]233 + 's')
$html = $html.Replace('FrancÃ©s', 'Franc' + [char]233 + 's')
$html = $html.Replace('AlemÃ¡n', 'Alem' + [char]225 + 'n')
$html = $html.Replace('aÃ±os', 'a' + [char]241 + 'os')
$html = $html.Replace('DÃ©srtico', 'D' + [char]233 + 'srtico')
$html = $html.Replace('DÃ©s', 'D' + [char]233 + 's')
$html = $html.Replace('Ã©', [char]233)
$html = $html.Replace('Ã¡', [char]225)
$html = $html.Replace('Ã³', [char]243)
$html = $html.Replace('Ã­', [char]237)
$html = $html.Replace('Ã±', [char]241)
$html = $html.Replace('Ãº', [char]250)
$html = $html.Replace('Ã¼', [char]252)

# Euro sign corrupto
$html = $html.Replace('â‚¬', [char]0x20AC)

# En-dash / em-dash corruptos
$html = $html.Replace('â€"', [char]0x2013)
$html = $html.Replace('â€"', [char]0x2014)

# Checkmark corrupto âœ… → ✅
$html = $html.Replace('âœ…', [char]0x2705)

# Flag emojis corruptos en dataPaises nombres (con img tags, dejar solo texto)
# Los img tags con flagcdn están bien, solo limpiar emojis sueltos corruptos
$html = [regex]::Replace($html, 'ðŸ‡[^\s''<]+', '')

# Limpiar espacios dobles que puedan quedar
$html = [regex]::Replace($html, "nombre: '([^']+)  '", "nombre: '`$1'")
$html = [regex]::Replace($html, "  '", " '")

[System.IO.File]::WriteAllText($path, $html, $enc)
Write-Host "[OK] Encoding fix aplicado"

# Verificar
if ($html -like '*Ã*') { Write-Host "[WARN] Quedan secuencias Ã corruptas" }
else { Write-Host "[OK] Sin secuencias Ã corruptas" }
if ($html -like '*ðŸ*') { Write-Host "[WARN] Quedan emojis corruptos ðŸ" }
else { Write-Host "[OK] Sin emojis corruptos" }
