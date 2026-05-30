$content = [System.IO.File]::ReadAllText('C:\Users\User\.claude\navia-website\index.html', [System.Text.Encoding]::UTF8)

# Find "Canad" and show the codepoint of char after it
$idx = $content.IndexOf('Canad')
if ($idx -ge 0) {
    $cp = [int]($content[$idx + 5])
    Write-Host ("Char after 'Canad': U+{0:X4}" -f $cp)
}

$idx2 = $content.IndexOf('Duraci')
if ($idx2 -ge 0) {
    $cp = [int]($content[$idx2 + 6])
    Write-Host ("Char after 'Duraci': U+{0:X4}" -f $cp)
}

# Count total replacement chars (U+FFFD)
$count = ($content.ToCharArray() | Where-Object { [int]$_ -eq 0xFFFD }).Count
Write-Host "Total U+FFFD chars: $count"

# Promo icon codepoints
$pi = $content.IndexOf('promo-icon">')
$iconContent = $content.Substring($pi + 12, 6)
foreach ($c in $iconContent.ToCharArray()) {
    $cp = [int]$c
    Write-Host ("Icon char: U+{0:X4}" -f $cp)
}

# Show flag emoji section in comparador
$compStart = $content.IndexOf('id="comparador"')
$compSnip = $content.Substring($compStart, 1500)
$optMatches = [regex]::Matches($compSnip, '<option[^>]*>([^<]+)</option>')
foreach ($m in $optMatches) {
    $val = $m.Groups[1].Value
    $hasSpecial = $false
    foreach ($c in $val.ToCharArray()) { if ([int]$c -gt 127) { $hasSpecial = $true } }
    if ($hasSpecial) {
        $chars = $val.ToCharArray() | ForEach-Object { "U+{0:X4}" -f [int]$_ }
        Write-Host ("Option '$val' => " + ($chars -join ' '))
    }
}
