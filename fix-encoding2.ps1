$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$a  = [char]225  # a con acento
$e  = [char]233  # e con acento
$i  = [char]237  # i con acento
$o  = [char]243  # o con acento
$u  = [char]250  # u con acento
$n  = [char]241  # enie
$eu = [char]0x20AC  # euro

# ── Nuevo bloque destinoInfo completamente limpio ─────────────────────────
$oldInfo = $html.IndexOf('const destinoInfo = {')
$oldInfoEnd = $html.IndexOf('};', $oldInfo) + 2
$beforeInfo = $html.Substring(0, $oldInfo)
$afterInfo  = $html.Substring($oldInfoEnd)

$newInfo = "const destinoInfo = {" +
"australia: { nombre: 'Australia', moneda: 'AUD', part: 200, general: 250, intensive: 313 }," +
"nz: { nombre: 'Nueva Zelanda', moneda: 'NZD', part: 200, general: 250, intensive: 313 }," +
"irlanda: { nombre: 'Irlanda', moneda: 'EUR', part: 100, general: 125, intensive: 156 }," +
"malta: { nombre: 'Malta', moneda: 'EUR', part: 107, general: 133, intensive: 167 }," +
"dubai: { nombre: 'Dubai', moneda: 'USD', part: 133, general: 167, intensive: 208 }," +
"canada: { nombre: 'Canad" + $a + "', moneda: 'CAD', part: 133, general: 167, intensive: 208 }," +
"usa: { nombre: 'Estados Unidos', moneda: 'USD', part: 167, general: 208, intensive: 260 }," +
"uk: { nombre: 'Reino Unido', moneda: 'GBP', part: 133, general: 167, intensive: 208 }," +
"francia: { nombre: 'Francia', moneda: 'EUR', part: 167, general: 208, intensive: 260 }," +
"alemania: { nombre: 'Alemania', moneda: 'EUR', part: 133, general: 167, intensive: 208 }" +
"};"

$html = $beforeInfo + $newInfo + $afterInfo

# ── Nuevo bloque dataPaises completamente limpio ──────────────────────────
$oldData = $html.IndexOf('const dataPaises = {')
$oldDataEnd = $html.IndexOf('};', $oldData) + 2
$beforeData = $html.Substring(0, $oldData)
$afterData  = $html.Substring($oldDataEnd)

$newData = "const dataPaises = {" +
"australia: { nombre: '<img src=""https://flagcdn.com/w40/au.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Australia', costo: 'AUD `$6,000 / 6 meses', trabajo: '24h/semana (48h quincenales)', clima: 'Templado / C" + $a + "lido', salario: 'AUD `$24.95/hora', idioma: 'Ingl" + $e + "s', postEstudio: 'Visa 485 (2-4 a" + $n + "os)', ciudades: 'Sydney, Melbourne, Brisbane' }," +
"nz: { nombre: '<img src=""https://flagcdn.com/w40/nz.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Nueva Zelanda', costo: 'NZD `$6,000 / 6 meses', trabajo: '25h/semana', clima: 'Templado', salario: 'NZD `$23.15/hora', idioma: 'Ingl" + $e + "s', postEstudio: 'Post Study Work 3 a" + $n + "os', ciudades: 'Auckland, Wellington, Christchurch' }," +
"irlanda: { nombre: '<img src=""https://flagcdn.com/w40/ie.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Irlanda', costo: 'EUR " + $eu + "3,000 / 25 semanas', trabajo: '20h/semana (40h vacaciones)', clima: 'Templado / Lluvioso', salario: 'EUR " + $eu + "13.50/hora', idioma: 'Ingl" + $e + "s', postEstudio: 'Stay Back graduados (limitado)', ciudades: 'Dubl" + $i + "n, Cork, Galway' }," +
"malta: { nombre: '<img src=""https://flagcdn.com/w40/mt.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Malta', costo: 'EUR " + $eu + "3,200 / 6 meses', trabajo: '20h/semana', clima: 'Mediterr" + $a + "neo', salario: 'EUR " + $eu + "5.42/hora', idioma: 'Ingl" + $e + "s / Malt" + $e + "s', postEstudio: 'Limitado', ciudades: 'Valletta, Sliema, St. Julian' }," +
"dubai: { nombre: '<img src=""https://flagcdn.com/w40/ae.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Dubai', costo: 'USD `$4,000 / 6 meses', trabajo: 'Var" + $i + "a seg" + $u + "n escuela', clima: 'Desiert " + $o + " / Muy c" + $a + "lido', salario: 'Sin salario m" + $i + "nimo', idioma: 'Ingl" + $e + "s / " + $a + "rabe', postEstudio: 'Limitado', ciudades: 'Dub" + $a + "i, Abu Dhabi' }," +
"canada: { nombre: '<img src=""https://flagcdn.com/w40/ca.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Canad" + $a + "', costo: 'CAD `$4,000 / 6 meses', trabajo: '20h/semana', clima: 'Fr" + $i + "o', salario: 'CAD ~`$17/hora (var" + $i + "a prov.)', idioma: 'Ingl" + $e + "s / Franc" + $e + "s', postEstudio: 'PGWP hasta 3 a" + $n + "os + PR pathway', ciudades: 'Toronto, Vancouver, Montreal' }," +
"usa: { nombre: '<img src=""https://flagcdn.com/w40/us.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Estados Unidos', costo: 'USD `$5,000 / 6 meses', trabajo: 'No permitido (F-1 primer a" + $n + "o)', clima: 'Var" + $i + "a por ciudad', salario: 'USD `$7.25+/hora (var" + $i + "a estado)', idioma: 'Ingl" + $e + "s', postEstudio: 'OPT hasta 3 a" + $n + "os (STEM)', ciudades: 'Nueva York, Miami, Boston, LA' }," +
"uk: { nombre: '<img src=""https://flagcdn.com/w40/gb.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Reino Unido', costo: 'GBP 4,000 / 6 meses', trabajo: '20h/semana', clima: 'Templado / Lluvioso', salario: 'GBP 11.44/hora', idioma: 'Ingl" + $e + "s', postEstudio: 'Graduate Route 2-3 a" + $n + "os', ciudades: 'Londres, Manchester, Edimburgo' }," +
"francia: { nombre: '<img src=""https://flagcdn.com/w40/fr.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Francia', costo: 'EUR " + $eu + "5,000 / 6 meses', trabajo: '20h/semana', clima: 'Templado / Continental', salario: 'EUR " + $eu + "11.88/hora (SMIC)', idioma: 'Franc" + $e + "s / Ingl" + $e + "s', postEstudio: 'Limitado', ciudades: 'Par" + $i + "s, Lyon, Niza, Burdeos' }," +
"alemania: { nombre: '<img src=""https://flagcdn.com/w40/de.png"" width=""20"" style=""vertical-align:middle;margin-right:5px;""> Alemania', costo: 'EUR " + $eu + "4,000 / 6 meses', trabajo: '20h/semana', clima: 'Continental / Fr" + $i + "o', salario: 'EUR " + $eu + "12.82/hora (Mindestlohn)', idioma: 'Alem" + $a + "n / Ingl" + $e + "s', postEstudio: 'Job Seeker Visa hasta 18 meses', ciudades: 'Berl" + $i + "n, M" + $u + "nich, Hamburgo' }" +
"};"

$html = $beforeData + $newData + $afterData

# ── Fix textos garbled en calc-detalles ────────────────────────────────────
$html = $html.Replace('DuraciÃ³n', 'Duraci' + $o + 'n')
$html = $html.Replace('matrÃ­cula', 'matr' + $i + 'cula')

# Regex para cualquier secuencia Ã restante
$html = [regex]::Replace($html, 'CanadÃ¡', 'Canad' + $a)
$html = [regex]::Replace($html, 'Ã©', $e)
$html = [regex]::Replace($html, 'Ã¡', $a)
$html = [regex]::Replace($html, 'Ã³', $o)
$html = [regex]::Replace($html, 'Ã­', $i)
$html = [regex]::Replace($html, 'Ãº', $u)
$html = [regex]::Replace($html, 'Ã±', $n)

# Emojis corruptos (secuencias ðŸ) en cualquier parte restante
$html = [regex]::Replace($html, 'ðŸ[\w-￿]+', '')

[System.IO.File]::WriteAllText($path, $html, $enc)
Write-Host "[OK] Encoding completamente reparado"

# Verificaciones
$checks = @(
    @{ pattern = 'Ã'; label = 'secuencias Ã corruptas' },
    @{ pattern = 'ðŸ'; label = 'emojis corruptos ðŸ' }
)
foreach ($c in $checks) {
    if ($html -like ('*' + $c.pattern + '*')) {
        Write-Host "[WARN] Quedan: $($c.label)"
    } else {
        Write-Host "[OK] Limpio: $($c.label)"
    }
}
