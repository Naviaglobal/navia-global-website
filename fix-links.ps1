$dir = 'C:\Users\User\.claude\navia-website'

# Mapa de enlaces rotos -> correctos
$fixes = @{
    '/blog/estudiar-ingles-australia-colombia.html' = '/blog/estudiar-australia-colombia-2026.html'
    '/blog/estudiar-ingles-canada-colombia.html'    = '/blog/estudiar-canada-colombia-2026.html'
    '/blog/estudiar-ingles-uk-colombia.html'        = '/blog/estudiar-reino-unido-colombia-2026.html'
    '/blog/estudiar-ingles-usa-colombia.html'       = '/blog/estudiar-estados-unidos-colombia-2026.html'
    '/blog/estudiar-nueva-zelanda-colombia.html'    = '/blog/estudiar-nueva-zelanda-colombia-2026.html'
    '/blog/estudiar-reino-unido-colombia.html'      = '/blog/estudiar-reino-unido-colombia-2026.html'
    '/blog/visa-estudiante-canada-colombia.html'    = '/blog/visa-estudiante-canada-2026.html'
    '/destinos.html'                                = '/blog/'
}

$files = Get-ChildItem $dir -Recurse -Filter '*.html' | Where-Object { $_.Name -notmatch '^tpl-' }
$totalFixed = 0

foreach($file in $files) {
    $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $changed = $false
    foreach($wrong in $fixes.Keys) {
        if($c.Contains($wrong)) {
            $c = $c.Replace($wrong, $fixes[$wrong])
            $changed = $true
            $totalFixed++
            Write-Host "FIXED: $wrong -> $($fixes[$wrong]) en $($file.Name)"
        }
    }
    if($changed) {
        [System.IO.File]::WriteAllText($file.FullName, $c, [System.Text.Encoding]::UTF8)
    }
}

Write-Host ""
Write-Host "Total reemplazos: $totalFixed"
