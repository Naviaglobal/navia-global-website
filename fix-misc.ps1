$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# ── 1. ELIMINAR el bloque JS de notificaciones falsas ─────────────────────
$html = [regex]::Replace($html, '(?s)// ========== NOTIFICACIONES POPUP \(M[^=]+=+\)[^\r\n]*\r?\n.*?setTimeout\(showNotification, 8000\);', '// Notificaciones popup eliminadas')

# ── 2. Tambien por si acaso buscar el bloque por otro patron ──────────────
$html = [regex]::Replace($html, '(?s)const notifications = \[.*?setTimeout\(showNotification, 8000\);', '// popup notifications removed')

# ── 3. CORREGIR boton "30 Guias" to "55 Guias" ───────────────────────────
$html = $html.Replace('Ver las 30 Gu', 'Ver las 55 Gu')

# ── 4. CORREGIR live stats 8 Destinos to 10 ──────────────────────────────
$html = [regex]::Replace($html, '(<div class="stat-number-live">)8(</div>\s*<div class="stat-label-live">Destinos disponibles)', '${1}10${2}')

# ── 5. Fechas ─────────────────────────────────────────────────────────────
$html = $html.Replace('Actualizado Abr 2026', 'May 2026')
$html = $html.Replace('>Abr 2026<', '>May 2026<')

[System.IO.File]::WriteAllText($path, $html, $enc)
Write-Host "[OK] Done."

# Verificar que el popup JS fue eliminado
if ($html -like '*showNotification*') {
    Write-Host "[WARN] showNotification todavia presente"
} else {
    Write-Host "[OK] Notificaciones falsas eliminadas"
}
if ($html -like '*Ver las 55*') { Write-Host "[OK] Boton 55 guias" }
