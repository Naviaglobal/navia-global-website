$enc = New-Object System.Text.UTF8Encoding($false)
$file = 'C:\Users\User\.claude\navia-website\index.html'
$html = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# ─── 1. FIX H2 CALCULATOR: add color to .calc-container h2 in CSS ───────────
# Find the style block for .calc-container and inject h2 color fix
# The calc-container likely has white background and the h2 inherits white color
# We'll add an inline color override on the h2 tag itself
$html = $html.Replace(
    '<h2>Calcula el Costo de Tu Programa</h2>',
    '<h2 style="color:#0A2463;font-size:1.6rem;margin-bottom:20px">Calcula el Costo de Tu Programa</h2>'
)

# ─── 2. FIX FLAG EMOJIS IN COMPARADOR: replace mojibake with HTML entities ───
# Each flag emoji (U+1F1xx + U+1F1xx) was stored as 4 Latin-1 chars from the UTF-8 bytes
# Australia 🇦🇺 U+1F1E6 U+1F1FA → F0 9F 87 A6 F0 9F 87 BA → ðŸ‡¦ðŸ‡º
$au = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00A6 + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00BA
# Canada 🇨🇦 U+1F1E8 U+1F1E6 → F0 9F 87 A8 F0 9F 87 A6
$ca = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00A8 + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00A6
# Ireland 🇮🇪 U+1F1EE U+1F1EA → F0 9F 87 AE F0 9F 87 AA
$ie = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00AE + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00AA
# Malta 🇲🇹 U+1F1F2 U+1F1F9 → F0 9F 87 B2 F0 9F 87 B9
$mt = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00B2 + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00B9
# UAE/Dubai 🇦🇪 U+1F1E6 U+1F1EA → F0 9F 87 A6 F0 9F 87 AA
$ae = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00A6 + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00AA
# USA 🇺🇸 U+1F1FA U+1F1F8 → F0 9F 87 BA F0 9F 87 B8
$us = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00BA + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00B8
# New Zealand 🇳🇿 U+1F1F3 U+1F1FF → F0 9F 87 B3 F0 9F 87 BF
$nz = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00B3 + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00BF
# UK 🇬🇧 U+1F1EC U+1F1E7 → F0 9F 87 AC F0 9F 87 A7
$gb = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00AC + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00A7
# France 🇫🇷 U+1F1EB U+1F1F7 → F0 9F 87 AB F0 9F 87 B7
$fr = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00AB + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00B7
# Germany 🇩🇪 U+1F1E9 U+1F1EA → F0 9F 87 A9 F0 9F 87 AA
$de = [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00A9 + [char]0x00F0 + [char]0x0178 + [char]0x2021 + [char]0x00AA

$html = $html.Replace($au + ' Australia', '&#x1F1E6;&#x1F1FA; Australia')
$html = $html.Replace($ca + ' Canada', '&#x1F1E8;&#x1F1E6; Canada')
$html = $html.Replace($ca + " Canad" + [char]0x00E1, "&#x1F1E8;&#x1F1E6; Canad" + [char]0x00E1)
$html = $html.Replace($ie + ' Irlanda', '&#x1F1EE;&#x1F1EA; Irlanda')
$html = $html.Replace($mt + ' Malta', '&#x1F1F2;&#x1F1F9; Malta')
$html = $html.Replace($ae + ' Dubai', '&#x1F1E6;&#x1F1EA; Dubai')
$html = $html.Replace($us + ' Estados Unidos', '&#x1F1FA;&#x1F1F8; Estados Unidos')
$html = $html.Replace($nz + ' Nueva Zelanda', '&#x1F1F3;&#x1F1FF; Nueva Zelanda')
$html = $html.Replace($gb + ' Reino Unido', '&#x1F1EC;&#x1F1E7; Reino Unido')
$html = $html.Replace($fr + ' Francia', '&#x1F1EB;&#x1F1F7; Francia')
$html = $html.Replace($de + ' Alemania', '&#x1F1E9;&#x1F1EA; Alemania')

# ─── 3. FIX PROMO ICON: UTF-16 surrogates (U+D83C U+DF81 = 🎁) ───────────────
$surrogate = [char]0xD83C + [char]0xDF81
$html = $html.Replace(
    '<div class="promo-icon">' + $surrogate + '</div>',
    '<div class="promo-icon">&#x1F381;</div>'
)

# ─── 4. NAV: Change "Servicios" link to "¿Cómo Funciona?" pointing to #proceso ─
# Desktop nav
$o = [char]0x00F3
$i = [char]0x00ED

$html = $html.Replace(
    '<a href="#servicios"',
    '<a href="#proceso"'
)
$html = $html.Replace(
    '>Servicios<',
    ">" + [char]0x00BF + "C" + [char]0x00F3 + "mo Funciona?<"
)

# ─── 5. REMOVE SERVICIOS SECTION ─────────────────────────────────────────────
$svcStart = $html.IndexOf('<section id="servicios"')
if ($svcStart -ge 0) {
    # Find the matching </section> after it
    $searchFrom = $svcStart + 10
    $depth = 0
    $pos = $svcStart
    while ($pos -lt $html.Length) {
        $openIdx = $html.IndexOf('<section', $pos + 1)
        $closeIdx = $html.IndexOf('</section>', $pos + 1)
        if ($closeIdx -lt 0) { break }
        if ($openIdx -gt 0 -and $openIdx -lt $closeIdx) {
            $depth++
            $pos = $openIdx
        } else {
            if ($depth -eq 0) {
                $svcEnd = $closeIdx + 10  # length of '</section>'
                $html = $html.Substring(0, $svcStart) + $html.Substring($svcEnd)
                Write-Host "[OK] Seccion servicios eliminada"
                break
            }
            $depth--
            $pos = $closeIdx
        }
    }
} else {
    Write-Host "[SKIP] No se encontro seccion servicios"
}

# ─── SAVE ─────────────────────────────────────────────────────────────────────
[System.IO.File]::WriteAllText($file, $html, $enc)
Write-Host "[OK] index.html guardado"

# Verify fixes
$verify = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
Write-Host "H2 fix present:" ($verify -match 'color:#0A2463')
Write-Host "Flag AU entity present:" ($verify -match '1F1E6.*1F1FA.*Australia')
Write-Host "Promo icon entity present:" ($verify -match '1F381')
Write-Host "Nav proceso link:" ($verify -match 'href="#proceso"')
Write-Host "Servicios section gone:" (-not ($verify -match 'id="servicios"'))
