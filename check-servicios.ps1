$content = [System.IO.File]::ReadAllText('C:\Users\User\.claude\navia-website\index.html', [System.Text.Encoding]::UTF8)
$i = $content.IndexOf('id="servicios"')
Write-Host ("servicios id index: " + $i)
if ($i -ge 0) {
    $snippet = $content.Substring([Math]::Max(0,$i-40), 120)
    Write-Host $snippet
}
# Check what's around it - find the section tag before it
$sectionBefore = $content.LastIndexOf('<section', $i)
Write-Host ("section tag before at: " + $sectionBefore)
if ($sectionBefore -ge 0) {
    Write-Host $content.Substring($sectionBefore, 60)
}
