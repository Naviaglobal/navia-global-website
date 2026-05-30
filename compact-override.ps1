$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$override = @'

        /* ===== COMPACT REDESIGN OVERRIDE ===== */
        /* Navbar */
        .navbar { padding: 5px 0 !important; }
        .navbar.scrolled { padding: 4px 0 !important; }
        .nav-container { padding: 0 28px !important; }
        .logo img { height: 36px !important; }
        .logo-name { font-size: 1.05rem !important; }
        .logo-tagline { font-size: 0.72rem !important; margin-top: 1px !important; }

        /* Hero */
        .hero {
            margin-top: 56px !important;
            padding: 64px 40px 48px !important;
            min-height: 420px !important;
        }
        .hero-badge { padding: 7px 20px !important; margin-bottom: 16px !important; font-size: 0.85rem !important; }
        .hero h1 { font-size: 2.6rem !important; margin-bottom: 14px !important; }
        .hero p { font-size: 1.2rem !important; margin-bottom: 12px !important; }
        .hero-flags { gap: 12px !important; margin: 16px 0 !important; }
        .hero-cta { margin-top: 24px !important; }
        .btn-primary { padding: 14px 34px !important; font-size: 1rem !important; }
        .trust-badges { gap: 20px !important; margin-top: 32px !important; }
        .trust-badge { padding: 10px 16px !important; font-size: 0.85rem !important; gap: 8px !important; }
        .trust-badge span { font-size: 1.4rem !important; }

        /* Mobile nav top */
        .mobile-nav { top: 52px !important; }

        /* Sections */
        .section-title { font-size: 2.2rem !important; margin-bottom: 10px !important; }
        .section-subtitle { font-size: 1.05rem !important; margin-bottom: 36px !important; }

        /* Stats */
        .stat-number { font-size: 2.6rem !important; margin-bottom: 6px !important; }
        .stat-label { font-size: 1rem !important; }
        .stats { gap: 24px !important; margin-top: 28px !important; }
        .stat-item { padding: 20px !important; }

        /* Experiencia */
        .experiencia h2 { font-size: 2rem !important; margin-bottom: 12px !important; }
        .experiencia p { font-size: 1.05rem !important; margin: 0 auto 24px !important; }

        /* ===== MOBILE COMPACT ===== */
        @media (max-width: 768px) {
            .navbar { padding: 4px 0 !important; }
            .hero {
                margin-top: 52px !important;
                padding: 44px 18px 36px !important;
                min-height: 0 !important;
            }
            .hero h1 { font-size: 1.75rem !important; line-height: 1.25 !important; margin-bottom: 10px !important; }
            .hero p { font-size: 0.95rem !important; }
            .hero-badge { font-size: 0.78rem !important; padding: 6px 14px !important; margin-bottom: 12px !important; }
            .hero-flags { gap: 10px !important; margin: 12px 0 !important; }
            .hero-flags img { width: 32px !important; height: 24px !important; }
            .btn-primary { padding: 12px 26px !important; font-size: 0.9rem !important; }
            .hero-cta { margin-top: 18px !important; }
            .trust-badges { gap: 8px !important; margin-top: 20px !important; }
            .trust-badge { padding: 8px 14px !important; font-size: 0.8rem !important; }
            .section-title { font-size: 1.6rem !important; }
            .section-subtitle { font-size: 0.9rem !important; margin-bottom: 22px !important; }
            .destinos, .servicios { padding: 40px 14px !important; }
            .experiencia { padding: 40px 18px !important; }
            .experiencia h2 { font-size: 1.6rem !important; }
            .experiencia p { font-size: 0.9rem !important; }
            .stat-number { font-size: 2rem !important; }
            .stats { gap: 14px !important; }
            .contacto { padding: 40px 14px !important; }
            .form-container { padding: 22px 16px !important; }
            .form-container h2 { font-size: 1.45rem !important; }
            .footer { padding: 40px 16px 20px !important; }
            .destino-header { height: 155px !important; }
            .destino-content h3 { font-size: 1.2rem !important; }
        }
'@

# Inject before the closing </style> of the main block
$html = $html.Replace('        /* ===== COMPACT REDESIGN OVERRIDE ===== */', '')
$html = $html -replace '(?s)(        /\* ===== COMPACT REDESIGN OVERRIDE =====.*?@media.*?\}[^}]*\}\s*)', ''

# Find the first </style> tag and insert before it
$idx = $html.IndexOf('</style>')
if ($idx -gt 0) {
    $html = $html.Substring(0, $idx) + $override + "`n        " + $html.Substring($idx)
    Write-Host "[OK] Override injected before </style>"
} else {
    Write-Host "[ERR] </style> not found"
}

[System.IO.File]::WriteAllText($path, $html, $enc)
