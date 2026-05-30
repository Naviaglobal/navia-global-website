$enc = New-Object System.Text.UTF8Encoding($false)

# ════════════════════════════════════════════════════════
# 1. INDEX.HTML — Destino & Servicios cards override
# ════════════════════════════════════════════════════════
$idxPath = "C:\Users\User\.claude\navia-website\index.html"
$idx = [System.IO.File]::ReadAllText($idxPath, [System.Text.Encoding]::UTF8)

$idxOverride = @'

        /* ===== DESTINOS & SERVICIOS COMPACT v2 ===== */
        .destinos-grid {
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)) !important;
            gap: 18px !important;
        }
        .destino-card { min-height: auto !important; border-radius: 14px !important; }
        .destino-header { height: 140px !important; }
        .destino-content { padding: 16px 18px 18px !important; }
        .destino-content h3 { font-size: 1.15rem !important; margin-bottom: 4px !important; }
        .destino-tagline { font-size: 0.82rem !important; margin-bottom: 8px !important; min-height: 0 !important; }
        .destino-content > p { font-size: 0.85rem !important; margin-bottom: 8px !important; min-height: 0 !important; line-height: 1.5 !important; }
        .destino-price { font-size: 1rem !important; padding: 8px !important; margin: 8px 0 !important; }
        .destino-features { margin: 8px 0 !important; }
        .destino-features li { padding: 5px 0 !important; font-size: 0.82rem !important; gap: 6px !important; }
        .destino-btn { padding: 11px !important; font-size: 0.88rem !important; border-radius: 20px !important; }
        .destino-flag { padding: 6px 8px !important; border-radius: 7px !important; }
        .destino-badge { padding: 5px 10px !important; font-size: 0.75rem !important; }

        .servicios-grid {
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)) !important;
            gap: 18px !important;
            margin-top: 28px !important;
        }
        .servicio-card { padding: 22px 20px !important; border-radius: 14px !important; }
        .servicio-icon { width: 48px !important; height: 48px !important; font-size: 1.5rem !important; margin-bottom: 12px !important; border-radius: 12px !important; }
        .servicio-card h3 { font-size: 1.1rem !important; margin-bottom: 8px !important; }
        .servicio-card p { font-size: 0.85rem !important; margin-bottom: 14px !important; line-height: 1.6 !important; }
        .servicio-list li { padding: 6px 0 !important; font-size: 0.84rem !important; }

        @media (max-width: 768px) {
            .destinos-grid {
                grid-template-columns: 1fr 1fr !important;
                gap: 12px !important;
            }
            .destino-header { height: 110px !important; }
            .destino-content { padding: 12px !important; }
            .destino-content h3 { font-size: 1rem !important; }
            .destino-tagline, .destino-content > p { display: none !important; }
            .destino-features li { font-size: 0.78rem !important; }
            .destino-btn { padding: 9px !important; font-size: 0.82rem !important; }
            .servicios-grid { grid-template-columns: 1fr !important; gap: 12px !important; }
        }
'@

# Remove any previous v2 override
$idx = [regex]::Replace($idx, '(?s)/\* ===== DESTINOS & SERVICIOS COMPACT v2 =====.*?@media.*?\}[^}]*\}', '')

# Inject before the last </style>
$lastStyle = $idx.LastIndexOf('</style>')
if ($lastStyle -gt 0) {
    $idx = $idx.Substring(0, $lastStyle) + $idxOverride + "`n        " + $idx.Substring($lastStyle)
    Write-Host "[OK] index.html destino/servicios compact override injected"
}
[System.IO.File]::WriteAllText($idxPath, $idx, $enc)

# ════════════════════════════════════════════════════════
# 2. BLOG/INDEX.HTML — Cards compact + filter mobile fix
# ════════════════════════════════════════════════════════
$blogPath = "C:\Users\User\.claude\navia-website\blog\index.html"
$blog = [System.IO.File]::ReadAllText($blogPath, [System.Text.Encoding]::UTF8)

$blogOverride = @'

        /* ===== BLOG COMPACT + FILTER FIX ===== */
        /* Hero compacto */
        .hero { padding: 48px 40px 36px !important; }
        .hero h1 { font-size: 2rem !important; margin-bottom: 12px !important; }
        .hero .subtitle { font-size: 1.1rem !important; margin-bottom: 8px !important; }
        .hero .description { font-size: 0.92rem !important; margin-bottom: 20px !important; }
        .hero-stats { gap: 28px !important; margin-top: 20px !important; }
        .hero-stat-number { font-size: 1.9rem !important; margin-bottom: 2px !important; }
        .hero-stat-label { font-size: 0.85rem !important; }

        /* Filtros compactos */
        .filters { padding: 14px 40px !important; top: 56px !important; }
        .filter-btn { padding: 7px 16px !important; font-size: 0.85rem !important; }
        .filter-label { font-size: 0.9rem !important; }

        /* Blog grid compacto */
        .blog-container { padding: 40px 40px !important; }
        .blog-grid {
            grid-template-columns: repeat(auto-fill, minmax(290px, 1fr)) !important;
            gap: 20px !important;
        }
        .blog-card { border-radius: 14px !important; }
        .blog-card-image { height: 140px !important; }
        .blog-card-content { padding: 18px !important; }
        .blog-card h3 { font-size: 1.05rem !important; margin-bottom: 5px !important; line-height: 1.3 !important; }
        .blog-card-description { font-size: 0.82rem !important; margin-bottom: 10px !important; line-height: 1.45 !important; }
        .blog-card-highlights { gap: 4px !important; margin-bottom: 10px !important; }
        .blog-highlight { padding: 2px 8px !important; font-size: 0.7rem !important; }
        .blog-card-footer { padding-top: 12px !important; }
        .blog-card-link { padding: 9px 18px !important; font-size: 0.82rem !important; gap: 6px !important; border-radius: 20px !important; }

        /* CTA compacto */
        .cta-section { padding: 48px 40px !important; margin-top: 40px !important; }
        .cta-section h2 { font-size: 2rem !important; margin-bottom: 12px !important; }
        .cta-section p { font-size: 1rem !important; margin-bottom: 24px !important; }
        .cta-btn { padding: 13px 28px !important; font-size: 1rem !important; }

        /* MOBILE FIXES */
        @media (max-width: 768px) {
            /* FIX CRÍTICO: filtro sticky bloquea scroll en mobile */
            .filters {
                position: static !important;
                padding: 12px 16px !important;
                overflow-x: auto !important;
            }
            .filters-container {
                flex-wrap: nowrap !important;
                overflow-x: auto !important;
                padding-bottom: 4px !important;
                gap: 8px !important;
                -webkit-overflow-scrolling: touch !important;
            }
            .filter-btn {
                white-space: nowrap !important;
                flex-shrink: 0 !important;
                padding: 6px 14px !important;
                font-size: 0.8rem !important;
            }
            .filter-label { display: none !important; }

            .hero { padding: 36px 18px 28px !important; }
            .hero h1 { font-size: 1.6rem !important; }
            .hero .subtitle { font-size: 0.95rem !important; }
            .hero .description { font-size: 0.85rem !important; }
            .hero-stats { gap: 18px !important; }
            .hero-stat-number { font-size: 1.5rem !important; }

            .blog-container { padding: 20px 14px !important; }
            .blog-grid {
                grid-template-columns: 1fr !important;
                gap: 14px !important;
            }
            .blog-card-image { height: 120px !important; }
            .blog-card-content { padding: 14px !important; }
            .blog-card h3 { font-size: 0.95rem !important; }
            .blog-card-description { display: none !important; }
            .blog-card-footer { padding-top: 10px !important; }
            .blog-card-link { padding: 8px 14px !important; font-size: 0.78rem !important; }

            .cta-section { padding: 36px 16px !important; margin-top: 24px !important; }
            .cta-section h2 { font-size: 1.5rem !important; }
        }
'@

# Remove any previous blog compact override
$blog = [regex]::Replace($blog, '(?s)/\* ===== BLOG COMPACT \+ FILTER FIX =====.*?@media.*?\}[^}]*\}', '')

$lastStyle2 = $blog.LastIndexOf('</style>')
if ($lastStyle2 -gt 0) {
    $blog = $blog.Substring(0, $lastStyle2) + $blogOverride + "`n        " + $blog.Substring($lastStyle2)
    Write-Host "[OK] blog/index.html compact + mobile filter fix injected"
}
[System.IO.File]::WriteAllText($blogPath, $blog, $enc)

Write-Host "Done. Deploy now."
