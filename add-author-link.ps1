$enc = New-Object System.Text.UTF8Encoding($false)
$blogDir = "C:\Users\User\.claude\navia-website\blog"
$articles = Get-ChildItem $blogDir -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }

$authorTag = '<link rel="author" href="/sobre-samuel-sanchez.html">'
$processed = 0

foreach ($file in $articles) {
    $html = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    if ($html -notlike '*rel="author"*') {
        $canonical = '<link rel="canonical"'
        $replacement = $authorTag + "`n    " + $canonical
        $html = $html.Replace($canonical, $replacement)
        [System.IO.File]::WriteAllText($file.FullName, $html, $enc)
        $processed++
    }
}
Write-Host ("Author link added to $processed articles")
