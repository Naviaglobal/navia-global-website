$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add('http://localhost:4200/')
$listener.Start()
Write-Host "READY"
for ($i = 0; $i -lt 500; $i++) {
  $ctx = $listener.GetContext()
  $req = $ctx.Request
  $res = $ctx.Response
  $path = $req.Url.LocalPath.TrimStart('/')
  if ($path -eq '') { $path = 'index-elevated.html' }
  $file = Join-Path 'C:\Users\User\.claude\navia-website' $path
  if (Test-Path $file) {
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $ext = [System.IO.Path]::GetExtension($file)
    $res.ContentType = if ($ext -eq '.html') { 'text/html; charset=utf-8' } elseif ($ext -eq '.webp') { 'image/webp' } elseif ($ext -eq '.css') { 'text/css' } else { 'application/octet-stream' }
    $res.ContentLength64 = $bytes.Length
    $res.OutputStream.Write($bytes, 0, $bytes.Length)
  } else {
    $res.StatusCode = 404
  }
  $res.Close()
}
$listener.Stop()
