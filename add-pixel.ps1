$PIXEL_ID = '1628049611726524'
$dir = 'C:\Users\User\.claude\navia-website'

# Pixel snippet completo para inyectar en <head>
$pixelSnippet = "<!-- Meta Pixel --><script>!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','https://connect.facebook.net/en_US/fbevents.js');fbq('init','$PIXEL_ID');fbq('track','PageView');</script><noscript><img height=`"1`" width=`"1`" style=`"display:none`" src=`"https://www.facebook.com/tr?id=$PIXEL_ID&ev=PageView&noscript=1`"/></noscript><!-- End Meta Pixel -->"

# IDs incorrectos a reemplazar
$wrongIds = @('1118856203755274', '1941742975996934', '938949398972037')

$files = Get-ChildItem $dir -Recurse -Filter '*.html' | Where-Object { $_.FullName -notmatch 'node_modules' }

$fixed = 0
$added = 0
$skipped = 0

foreach($file in $files) {
    $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $changed = $false

    # 1. Reemplazar IDs incorrectos con el correcto
    foreach($wrongId in $wrongIds) {
        if($c.Contains($wrongId)) {
            $c = $c.Replace($wrongId, $PIXEL_ID)
            $changed = $true
            $fixed++
            Write-Host "FIXED ID in: $($file.Name)"
        }
    }

    # 2. Si no tiene pixel init, agregarlo antes de </head>
    $hasPixel = $c.Contains("fbq('init','$PIXEL_ID')") -or $c.Contains('fbq(''init'',''' + $PIXEL_ID + ''')')
    if(-not $hasPixel -and $c.Contains('</head>')) {
        $c = $c.Replace('</head>', $pixelSnippet + '</head>')
        $changed = $true
        $added++
        Write-Host "ADDED pixel to: $($file.Name)"
    } elseif($hasPixel) {
        # ya tiene pixel correcto
    } else {
        $skipped++
    }

    if($changed) {
        [System.IO.File]::WriteAllText($file.FullName, $c, [System.Text.Encoding]::UTF8)
    }
}

Write-Host ""
Write-Host "=== RESUMEN ==="
Write-Host "IDs corregidos: $fixed archivos"
Write-Host "Pixel agregado: $added archivos"
Write-Host "Sin cambios: $skipped archivos"
Write-Host "Total procesados: $($files.Count) archivos"
