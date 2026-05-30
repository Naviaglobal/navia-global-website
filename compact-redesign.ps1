$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# ── 1. NAVBAR: reduce padding, gap, font-size, CTA size ──────────────────
$html = $html.Replace('padding: 10px 0;
        transition: all 0.3s ease;', 'padding: 6px 0;
        transition: all 0.3s ease;')

$html = $html.Replace('.navbar.scrolled {
            padding: 8px 0;', '.navbar.scrolled {
            padding: 5px 0;')

$html = $html.Replace('padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;', 'padding: 0 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;')

$html = $html.Replace('gap: 45px;
            align-items: center;', 'gap: 28px;
            align-items: center;')

$html = $html.Replace('font-weight: 600;
            font-size: 1.05rem;
            transition: all 0.3s ease;
            position: relative;
            padding: 10px 5px;', 'font-weight: 600;
            font-size: 0.92rem;
            transition: all 0.3s ease;
            position: relative;
            padding: 6px 4px;')

$html = $html.Replace('padding: 14px 32px !important;
            border-radius: 30px !important;
            font-weight: 700 !important;
            font-size: 1.05rem !important;', 'padding: 10px 22px !important;
            border-radius: 30px !important;
            font-weight: 700 !important;
            font-size: 0.9rem !important;')

# logo img height 50px → 38px
$html = $html.Replace('        .logo img {
            height: 50px;', '        .logo img {
            height: 38px;')

# logo-name font-size
$html = $html.Replace('            font-size: 1.3rem;
            font-weight: 800;
            color: #1B4B8C;', '            font-size: 1.1rem;
            font-weight: 800;
            color: #1B4B8C;')

# logo-tagline font-size
$html = $html.Replace('            color: #1ABC9C;
            font-size: 0.85rem;
            font-weight: 500;
            margin-top: 4px;', '            color: #1ABC9C;
            font-size: 0.75rem;
            font-weight: 500;
            margin-top: 2px;')

# ── 2. HERO: reduce padding, min-height, font-sizes ──────────────────────
$html = $html.Replace('        margin-top: 80px;
        background: linear-gradient(135deg, #1B4B8C 0%, #296AB8 100%);
        padding: 120px 40px 100px;
        text-align: center;
        color: white;
        position: relative;
        overflow: hidden;
        min-height: 600px;', '        margin-top: 64px;
        background: linear-gradient(135deg, #1B4B8C 0%, #296AB8 100%);
        padding: 72px 40px 56px;
        text-align: center;
        color: white;
        position: relative;
        overflow: hidden;
        min-height: 460px;')

$html = $html.Replace('        .hero-badge {
            background: rgba(26,188,156,0.25);
            display: inline-block;
            padding: 14px 35px;
            border-radius: 35px;
            margin-bottom: 35px;', '        .hero-badge {
            background: rgba(26,188,156,0.25);
            display: inline-block;
            padding: 8px 22px;
            border-radius: 35px;
            margin-bottom: 18px;')

$html = $html.Replace('            font-size: 1.05rem;
            color: white;
            border: 2px solid rgba(26,188,156,0.4);', '            font-size: 0.88rem;
            color: white;
            border: 2px solid rgba(26,188,156,0.4);')

$html = $html.Replace('        .hero h1 {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 30px;', '        .hero h1 {
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 18px;')

$html = $html.Replace('        .hero p {
            font-size: 1.6rem;
            margin-bottom: 20px;', '        .hero p {
            font-size: 1.25rem;
            margin-bottom: 14px;')

$html = $html.Replace('            gap: 20px;
            justify-content: center;
            align-items: center;
            margin: 35px 0;', '            gap: 14px;
            justify-content: center;
            align-items: center;
            margin: 18px 0;')

$html = $html.Replace('        .hero-cta {
            margin-top: 50px;', '        .hero-cta {
            margin-top: 28px;')

$html = $html.Replace('        .btn-primary {
            background: #1ABC9C;
            color: white;
            padding: 22px 50px;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 800;
            font-size: 1.25rem;', '        .btn-primary {
            background: #1ABC9C;
            color: white;
            padding: 15px 36px;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 800;
            font-size: 1.05rem;')

$html = $html.Replace('            gap: 60px;
            margin-top: 70px;', '            gap: 24px;
            margin-top: 36px;')

$html = $html.Replace('        .trust-badge {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 1.05rem;
            background: rgba(255,255,255,0.1);
            padding: 18px 30px;', '        .trust-badge {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.88rem;
            background: rgba(255,255,255,0.1);
            padding: 10px 18px;')

$html = $html.Replace('        .trust-badge span {
            font-size: 2rem;', '        .trust-badge span {
            font-size: 1.5rem;')

# ── 3. SECCIONES: padding 120px → 64px ───────────────────────────────────
$html = $html.Replace('        .destinos {
            padding: 120px 40px;', '        .destinos {
            padding: 64px 40px;')

$html = $html.Replace('        .servicios {
            padding: 120px 40px;', '        .servicios {
            padding: 64px 40px;')

$html = $html.Replace('        .section-title {
            text-align: center;
            font-size: 3.5rem;', '        .section-title {
            text-align: center;
            font-size: 2.4rem;')

$html = $html.Replace('        .section-subtitle {
            text-align: center;
            font-size: 1.4rem;
            color: #7f8c8d;
            margin-bottom: 80px;', '        .section-subtitle {
            text-align: center;
            font-size: 1.1rem;
            color: #7f8c8d;
            margin-bottom: 40px;')

# ── 4. DESTINO CARDS: compactar ───────────────────────────────────────────
$html = $html.Replace('            min-height: 700px;', '            min-height: auto;')

$html = $html.Replace('        .destino-header {
            height: 220px;', '        .destino-header {
            height: 175px;')

$html = $html.Replace('        .destino-content {
            padding: 35px 30px;', '        .destino-content {
            padding: 20px 22px;')

$html = $html.Replace('        .destino-content h3 {
            font-size: 1.9rem;
            color: #1B4B8C;
            margin-bottom: 10px;', '        .destino-content h3 {
            font-size: 1.4rem;
            color: #1B4B8C;
            margin-bottom: 6px;')

$html = $html.Replace('        .destinos-grid {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 40px;', '        .destinos-grid {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;')

# ── 5. SERVICIOS CARDS: compactar ────────────────────────────────────────
$html = $html.Replace('        .servicios-grid {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
            gap: 45px;
            margin-top: 70px;', '        .servicios-grid {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-top: 36px;')

$html = $html.Replace('        .servicio-card {
            background: white;
            padding: 45px 35px;', '        .servicio-card {
            background: white;
            padding: 28px 24px;')

$html = $html.Replace('        .servicio-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #1ABC9C, #16A085);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin-bottom: 25px;', '        .servicio-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, #1ABC9C, #16A085);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 16px;')

$html = $html.Replace('        .servicio-card h3 {
            font-size: 1.6rem;
            color: #1B4B8C;
            margin-bottom: 18px;', '        .servicio-card h3 {
            font-size: 1.25rem;
            color: #1B4B8C;
            margin-bottom: 10px;')

# ── 6. EXPERIENCIA/STATS: compactar ──────────────────────────────────────
$html = $html.Replace('        .experiencia {
            padding: 100px 20px;', '        .experiencia {
            padding: 56px 20px;')

$html = $html.Replace('        .experiencia h2 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 25px;', '        .experiencia h2 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 14px;')

$html = $html.Replace('        .experiencia p {
            font-size: 1.4rem;
            opacity: 0.95;
            max-width: 800px;
            margin: 0 auto 50px;', '        .experiencia p {
            font-size: 1.1rem;
            opacity: 0.95;
            max-width: 800px;
            margin: 0 auto 28px;')

$html = $html.Replace('            gap: 50px;
            margin-top: 70px;', '            gap: 28px;
            margin-top: 32px;')

$html = $html.Replace('        .stat-number {
            font-size: 4rem;
            font-weight: 800;
            color: #1ABC9C;
            margin-bottom: 15px;', '        .stat-number {
            font-size: 2.8rem;
            font-weight: 800;
            color: #1ABC9C;
            margin-bottom: 8px;')

# ── 7. CONTACTO: compactar ────────────────────────────────────────────────
$html = $html.Replace('        .contacto {
            padding: 100px 20px;', '        .contacto {
            padding: 60px 20px;')

$html = $html.Replace('        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 60px 50px;', '        .form-container {
            max-width: 760px;
            margin: 0 auto;
            background: white;
            padding: 36px 36px;')

$html = $html.Replace('        .form-container h2 {
            text-align: center;
            color: #1B4B8C;
            font-size: 2.5rem;
            margin-bottom: 15px;', '        .form-container h2 {
            text-align: center;
            color: #1B4B8C;
            font-size: 1.9rem;
            margin-bottom: 10px;')

# ── 8. FOOTER: compactar ─────────────────────────────────────────────────
$html = $html.Replace('        .footer {
            background: #2C3E50;
            color: white;
            padding: 70px 20px 30px;', '        .footer {
            background: #2C3E50;
            color: white;
            padding: 48px 20px 24px;')

$html = $html.Replace('            gap: 50px;
            margin-bottom: 50px;', '            gap: 32px;
            margin-bottom: 32px;')

# ── 9. RESPONSIVE MOBILE (768px): ajustar ────────────────────────────────
$html = $html.Replace('            .hero {
                padding: 100px 25px 80px;
                margin-top: 75px;
            }', '            .hero {
                padding: 56px 20px 44px;
                margin-top: 58px;
            }')

$html = $html.Replace('            .hero h1 {
                font-size: 2.5rem;
                line-height: 1.3;
            }', '            .hero h1 {
                font-size: 1.9rem;
                line-height: 1.3;
            }')

$html = $html.Replace('            .hero p {
                font-size: 1.2rem;
            }', '            .hero p {
                font-size: 1rem;
            }')

$html = $html.Replace('            .btn-primary {
                padding: 18px 40px;
                font-size: 1.05rem;
            }', '            .btn-primary {
                padding: 13px 28px;
                font-size: 0.95rem;
            }')

$html = $html.Replace('            .section-title {
                font-size: 2.5rem;
            }', '            .section-title {
                font-size: 1.8rem;
            }')

$html = $html.Replace('            .section-subtitle {
                font-size: 1.15rem;
                margin-bottom: 60px;
            }', '            .section-subtitle {
                font-size: 0.95rem;
                margin-bottom: 28px;
            }')

$html = $html.Replace('            .destinos,
            .servicios {
                padding: 80px 25px;
            }', '            .destinos,
            .servicios {
                padding: 44px 16px;
            }')

$html = $html.Replace('            .form-container {
                padding: 45px 30px;
            }', '            .form-container {
                padding: 24px 18px;
            }')

$html = $html.Replace('            .form-container h2 {
                font-size: 2.2rem;
            }', '            .form-container h2 {
                font-size: 1.5rem;
            }')

$html = $html.Replace('            .stats {
                grid-template-columns: repeat(2, 1fr);
                gap: 40px;
            }', '            .stats {
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }')

$html = $html.Replace('            .stat-number {
                font-size: 3.5rem;
            }', '            .stat-number {
                font-size: 2.4rem;
            }')

$html = $html.Replace('            .experiencia {
                padding: 80px 25px;
            }', '            .experiencia {
                padding: 44px 20px;
            }')

$html = $html.Replace('            .experiencia h2 {
                font-size: 2.5rem;
            }', '            .experiencia h2 {
                font-size: 1.8rem;
            }')

$html = $html.Replace('            .experiencia p {
                font-size: 1.15rem;
            }', '            .experiencia p {
                font-size: 0.95rem;
            }')

$html = $html.Replace('            .trust-badges {
                flex-direction: column;
                gap: 25px;
                align-items: center;
            }', '            .trust-badges {
                flex-direction: column;
                gap: 10px;
                align-items: center;
            }')

# Mobile: nav margin-top adjustment
$html = $html.Replace('        .mobile-nav {
            display: none;
            position: fixed;
            top: 70px;', '        .mobile-nav {
            display: none;
            position: fixed;
            top: 54px;')

[System.IO.File]::WriteAllText($path, $html, $enc)
Write-Host "Compact redesign applied to index.html"
