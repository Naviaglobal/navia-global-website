$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\blog\index.html"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$flagMap = @{
    'australia'      = 'au'
    'irlanda'        = 'ie'
    'dublin'         = 'ie'
    'cork'           = 'ie'
    'canada'         = 'ca'
    'toronto'        = 'ca'
    'vancouver'      = 'ca'
    'reino-unido'    = 'gb'
    'londre'         = 'gb'
    'manchester'     = 'gb'
    'nueva-zelanda'  = 'nz'
    'auckland'       = 'nz'
    'malta'          = 'mt'
    'dubai'          = 'ae'
    'estados-unidos' = 'us'
    'nueva-york'     = 'us'
    'miami'          = 'us'
    'alemania'       = 'de'
    'francia'        = 'fr'
}

$labelMap = @{
    'au' = 'Australia'
    'ie' = 'Irlanda'
    'ca' = 'Canada'
    'gb' = 'Reino Unido'
    'nz' = 'Nueva Zelanda'
    'mt' = 'Malta'
    'ae' = 'Dubai'
    'us' = 'USA'
    'de' = 'Alemania'
    'fr' = 'Francia'
}

$lines = $content -split "`n"
$output = New-Object System.Collections.Generic.List[string]
$changed = 0

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]

    if ($line -match 'class="blog-card-flag"') {
        $foundFlag = $null
        $secondFlag = $null

        for ($j = $i+1; $j -lt [Math]::Min($i+35, $lines.Count); $j++) {
            if ($lines[$j] -match 'href="/blog/([^"]+)"') {
                $url = $matches[1].ToLower()
                $isVs = $url -match '-vs-'

                $keys = @($flagMap.Keys)
                for ($k = 0; $k -lt $keys.Count; $k++) {
                    $key = $keys[$k]
                    if ($url -like "*$key*") {
                        if ($null -eq $foundFlag) {
                            $foundFlag = $flagMap[$key]
                        } elseif ($isVs -and $foundFlag -ne $flagMap[$key]) {
                            $secondFlag = $flagMap[$key]
                        }
                    }
                }
                break
            }
        }

        if ($foundFlag) {
            $label = $labelMap[$foundFlag]
            $indent = ''
            if ($line -match '^(\s+)') { $indent = $matches[1] }

            if ($secondFlag -and $secondFlag -ne $foundFlag) {
                $label2 = $labelMap[$secondFlag]
                $flagHtml = $indent + '<span class="blog-card-flag">'
                $flagHtml += '<img src="https://flagcdn.com/w40/' + $foundFlag + '.png" alt="' + $label + '" loading="lazy">'
                $flagHtml += '<img src="https://flagcdn.com/w40/' + $secondFlag + '.png" alt="' + $label2 + '" loading="lazy" style="margin-left:3px;">'
                $flagHtml += '<span>' + $label + ' vs ' + $label2 + '</span></span>'
            } else {
                $flagHtml = $indent + '<span class="blog-card-flag">'
                $flagHtml += '<img src="https://flagcdn.com/w40/' + $foundFlag + '.png" alt="' + $label + '" loading="lazy">'
                $flagHtml += '<span>' + $label + '</span></span>'
            }
            $line = $flagHtml
            $changed++
        }
        # If no country found, leave as-is (thematic cards)
    }

    $output.Add($line)
}

Write-Host ("Replaced " + $changed + " flag spans")

$newContent = $output -join "`n"
[System.IO.File]::WriteAllText($path, $newContent, $enc)
Write-Host "Saved OK"
