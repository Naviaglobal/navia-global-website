$enc = New-Object System.Text.UTF8Encoding($false)

# ════════════════════════════════════════════════════════
# 1. INDEX.HTML — Override destino cards: ocultar tagline+desc,
#    rediseñar a chips pill compactos, limitar bullets a 3
# ════════════════════════════════════════════════════════
$idxPath = "C:\Users\User\.claude\navia-website\index.html"
$idx = [System.IO.File]::ReadAllText($idxPath, [System.Text.Encoding]::UTF8)

$override = @'

        /* ===== DESTINO CARDS CONTENT CLEAN v3 ===== */
        /* Ocultar elementos verbose */
        .destino-tagline { display: none !important; }
        .destino-content > p:not(.destino-tagline) { display: none !important; }

        /* Limitar bullets a los primeros 3 */
        .destino-features li:nth-child(n+4) { display: none !important; }

        /* Precio más compacto */
        .destino-price {
            font-size: 0.88rem !important;
            padding: 6px 10px !important;
            margin: 8px 0 !important;
            border-radius: 8px !important;
        }

        /* Features: chips horizontales compactos */
        .destino-features {
            display: flex !important;
            flex-wrap: wrap !important;
            gap: 5px !important;
            margin: 6px 0 8px !important;
        }
        .destino-features li {
            background: #EEF4FF !important;
            color: #1B4B8C !important;
            padding: 3px 10px !important;
            border-radius: 20px !important;
            font-size: 0.75rem !important;
            font-weight: 600 !important;
            display: inline-flex !important;
            align-items: center !important;
            gap: 0 !important;
            line-height: 1.4 !important;
            border: none !important;
        }
        .destino-features li::before { display: none !important; }
        .destino-features li strong {
            color: inherit !important;
            font-weight: 600 !important;
        }
        /* Ocultar el texto después del colon en features para máxima compacidad */
        .destino-features li strong + * { display: none !important; }

        /* Card height contenido mínimo */
        .destino-content {
            padding: 14px 16px 16px !important;
        }
        .destino-content h3 {
            font-size: 1.1rem !important;
            margin-bottom: 6px !important;
            font-weight: 800 !important;
        }
        .destino-btn {
            margin-top: 8px !important;
            padding: 10px 16px !important;
            font-size: 0.82rem !important;
            border-radius: 20px !important;
            text-align: center !important;
        }

        /* Header imagen */
        .destino-header { height: 130px !important; }

        /* Grid más columnas */
        .destinos-grid {
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)) !important;
            gap: 16px !important;
        }
        .destino-card { min-height: auto !important; }

        @media (max-width: 900px) {
            .destinos-grid {
                grid-template-columns: repeat(2, 1fr) !important;
                gap: 12px !important;
            }
            .destino-header { height: 100px !important; }
        }
        @media (max-width: 480px) {
            .destinos-grid {
                grid-template-columns: repeat(2, 1fr) !important;
                gap: 10px !important;
            }
        }
'@

# Limpiar versiones anteriores del override v3
$idx = [regex]::Replace($idx, '(?s)/\* ===== DESTINO CARDS CONTENT CLEAN v3 =====.*?(?=\s{0,8}/\* ===|</style>)', '')
$idx = [regex]::Replace($idx, '(?s)/\* ===== DESTINO CARDS CONTENT CLEAN v3 =====.*?@media[^}]+\}[^}]*\}\s*', '')

$lastStyle = $idx.LastIndexOf('</style>')
$idx = $idx.Substring(0, $lastStyle) + $override + "`n        " + $idx.Substring($lastStyle)
[System.IO.File]::WriteAllText($idxPath, $idx, $enc)
Write-Host "[OK] index.html destino cards content clean injected"

# ════════════════════════════════════════════════════════
# 2. BLOG/INDEX.HTML — Navbar compacto
# ════════════════════════════════════════════════════════
$blogPath = "C:\Users\User\.claude\navia-website\blog\index.html"
$blog = [System.IO.File]::ReadAllText($blogPath, [System.Text.Encoding]::UTF8)

$navOverride = @'

        /* ===== BLOG NAVBAR COMPACT ===== */
        .navbar { padding: 6px 0 !important; }
        .nav-container { padding: 0 28px !important; }
        .logo img { height: 34px !important; margin-right: 8px !important; }
        .logo-name { font-size: 1.05rem !important; }
        .logo-tagline { font-size: 0.72rem !important; margin-top: 1px !important; }
        .nav-links { gap: 22px !important; }
        .nav-links a { font-size: 0.88rem !important; }
        .nav-cta { padding: 8px 18px !important; font-size: 0.85rem !important; }

        /* Filtros: sticky top ajustado al navbar compacto */
        .filters { top: 50px !important; padding: 10px 28px !important; }

        @media (max-width: 768px) {
            .navbar { padding: 5px 0 !important; }
            .nav-container { padding: 0 16px !important; }
            .logo img { height: 30px !important; }
            .logo-name { font-size: 0.95rem !important; }
            .logo-tagline { display: none !important; }
        }
'@

# Limpiar versión anterior
$blog = [regex]::Replace($blog, '(?s)/\* ===== BLOG NAVBAR COMPACT =====.*?@media[^}]+\}[^}]*\}', '')

$lastStyle2 = $blog.LastIndexOf('</style>')
$blog = $blog.Substring(0, $lastStyle2) + $navOverride + "`n        " + $blog.Substring($lastStyle2)

# Tambien fix inline: logo height=52px en el HTML del blog
$blog = $blog.Replace('style="height:52px;width:auto;margin-right:10px;"', 'style="height:34px;width:auto;margin-right:8px;"')

[System.IO.File]::WriteAllText($blogPath, $blog, $enc)
Write-Host "[OK] blog/index.html navbar compact injected"
Write-Host "Ready to deploy."
