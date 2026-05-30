$enc = New-Object System.Text.UTF8Encoding($false)

# ─── 1. BLOG INDEX ───────────────────────────────────────────────────────────
$path = 'C:\Users\User\.claude\navia-website\blog\index.html'
$c = [System.IO.File]::ReadAllText($path, $enc)

# Fix Malta card: EUR 80 → 20h/semana
$c = $c -replace '<div style="font-size:2\.4rem;font-weight:900;color:white;line-height:1;">EUR 80</div>\s*<div style="color:rgba\(255,255,255,\.85\);font-size:0\.85rem;font-weight:600;">Visa Schengen · 26 países</div>', '<div style="font-size:2.4rem;font-weight:900;color:white;line-height:1;">20h</div><div style="color:rgba(255,255,255,.85);font-size:0.85rem;font-weight:600;">/semana · trabajo legal</div>'

# Fix Malta card bottom text
$c = $c -replace 'Trabajo inmediato al llegar · ~EUR 900/mes', 'Trabajo inmediato al llegar · Visa Schengen'

# Fix Dubai card: $0 → 7 días
$c = $c -replace '<div style="font-size:2\.4rem;font-weight:900;color:white;line-height:1;">\$0</div>\s*<div style="color:rgba\(255,255,255,\.85\);font-size:0\.85rem;font-weight:600;">Solvencia requerida · Tax-free</div>', '<div style="font-size:2.4rem;font-weight:900;color:white;line-height:1;">7 días</div><div style="color:rgba(255,255,255,.85);font-size:0.85rem;font-weight:600;">aprobación visa · sin solvencia</div>'

# ─── 2. CSS: imagen 250→180px, flag modernizada ──────────────────────────────
$c = $c -replace '\.blog-card-image \{[^}]+height: 250px;', '.blog-card-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            transition: transform 0.4s;'

# Flag: emoji grande → pequeña bandera inline
$c = $c -replace '\.blog-card-flag \{\s*font-size: 3rem;\s*margin-bottom: 15px;\s*display: block;\s*\}', '.blog-card-flag {
            font-size: 0;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .blog-card-flag img {
            width: 28px;
            height: 20px;
            border-radius: 3px;
            object-fit: cover;
            box-shadow: 0 1px 4px rgba(0,0,0,0.15);
        }
        .blog-card-flag span {
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            color: #5a6a7e;
        }'

# Title: 1.7rem → 1.35rem
$c = $c -replace '\.blog-card h3 \{[^}]+font-size: 1\.7rem;', '.blog-card h3 {
            color: #1B4B8C;
            font-size: 1.35rem;
            margin-bottom: 10px;
            font-weight: 700;
            line-height: 1.3;'

# Description: 1.05rem → 0.92rem, margin reducido
$c = $c -replace '\.blog-card-description \{[^}]+font-size: 1\.05rem;[^}]+margin-bottom: 25px;', '.blog-card-description {
            color: #666;
            font-size: 0.92rem;
            line-height: 1.6;
            margin-bottom: 16px;'

# Content padding: 35px → 20px
$c = $c -replace '\.blog-card-content \{[^}]+\}', '.blog-card-content {
            padding: 20px 22px 22px;
        }'

# Highlights margin: 30px → 16px
$c = $c -replace '\.blog-card-highlights \{[^}]+margin-bottom: 30px;', '.blog-card-highlights {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-bottom: 16px;'

# Highlight pills: smaller
$c = $c -replace '\.blog-highlight \{[^}]+\}', '.blog-highlight {
            background: #EEF4FF;
            color: #1B4B8C;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.78rem;
            font-weight: 600;
        }'

# Badge: sin emoji styling
$c = $c -replace '\.blog-card-badge \{[^}]+\}', '.blog-card-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: rgba(255,255,255,0.96);
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.72rem;
            color: #1B4B8C;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
            z-index: 10;
        }'

# ─── 3. REPLACE EMOJI FLAGS WITH FLAGCDN IMAGES ──────────────────────────────
$flagMap = @(
    @{ emoji='🦘';  img='au'; label='Australia' },
    @{ emoji='🍀';  img='ie'; label='Irlanda' },
    @{ emoji='🍁';  img='ca'; label='Canadá' },
    @{ emoji='👑';  img='gb'; label='Reino Unido' },
    @{ emoji='🥝';  img='nz'; label='Nueva Zelanda' },
    @{ emoji='⚓';  img='mt'; label='Malta' },
    @{ emoji='🏙️'; img='ae'; label='Dubái' },
    @{ emoji='🦅';  img='us'; label='USA' },
    @{ emoji='🏆';  img='';  label='Ranking' },
    @{ emoji='💵';  img='us'; label='Costos' },
    @{ emoji='🌍';  img='';  label='Global' },
    @{ emoji='🇦🇺'; img='au'; label='Australia' },
    @{ emoji='🇮🇪'; img='ie'; label='Irlanda' },
    @{ emoji='🇩🇪'; img='de'; label='Alemania' },
    @{ emoji='🇬🇧'; img='gb'; label='UK' },
    @{ emoji='🇳🇿'; img='nz'; label='Nueva Zelanda' },
    @{ emoji='🇲🇹'; img='mt'; label='Malta' },
    @{ emoji='🇦🇺🆚🇮🇪'; img=''; label='AU vs IE' },
    @{ emoji='🇦🇺🆚🇨🇦'; img=''; label='AU vs CA' },
    @{ emoji='🇲🇹🆚🇮🇪'; img=''; label='MT vs IE' },
    @{ emoji='🇨🇦🆚🇬🇧'; img=''; label='CA vs UK' },
    @{ emoji='🏡';  img='';  label='Alojamiento' },
    @{ emoji='📚';  img='';  label='Guía' },
    @{ emoji='🇫🇷'; img='fr'; label='Francia' },
    @{ emoji='🇺🇸'; img='us'; label='USA' },
    @{ emoji='🇦🇪'; img='ae'; label='Dubái' },
    @{ emoji='💰';  img='';  label='Costos' },
    @{ emoji='🛂';  img='';  label='Visa' },
    @{ emoji='🎓';  img='';  label='Maestría' },
    @{ emoji='💶';  img='';  label='Europa' },
    @{ emoji='☘️';  img='ie'; label='Irlanda' },
    @{ emoji='⚽';  img='';  label='Ciudades' },
    @{ emoji='🗽';  img='us'; label='Nueva York' },
    @{ emoji='🏔️'; img='';  label='Vancouver' },
    @{ emoji='🏛️'; img='';  label='Londres' }
)

foreach ($f in $flagMap) {
    if ($f.img -ne '') {
        $imgTag = '<img src="https://flagcdn.com/w40/' + $f.img + '.png" alt="' + $f.label + '" loading="lazy"><span>' + $f.label + '</span>'
    } else {
        $imgTag = '<span style="font-size:1.1rem;">' + $f.label + '</span>'
    }
    $oldSpan = '<span class="blog-card-flag">' + $f.emoji + '</span>'
    $newSpan = '<span class="blog-card-flag">' + $imgTag + '</span>'
    $c = $c.Replace($oldSpan, $newSpan)
}

# ─── 4. BADGE TEXT: quitar emojis de badges ──────────────────────────────────
$c = $c -replace '⭐ Popular', 'POPULAR'
$c = $c -replace '🔥 Destacado', 'DESTACADO'
$c = $c -replace '👑 Premium', 'PREMIUM'
$c = $c -replace '🏅 Estrella', 'ESTRELLA'
$c = $c -replace '🆕 Nuevo', 'NUEVO'
$c = $c -replace '✅ Esencial', 'ESENCIAL'
$c = $c -replace '🔑 Clave', 'CLAVE'
$c = $c -replace '📊 Comparativa', 'COMPARATIVA'
$c = $c -replace '💡 Práctica', 'PRÁCTICA'
$c = $c -replace '🎓 Académico', 'ACADÉMICO'

# ─── 5. ADD QUICK INDEX antes del blog-container ────────────────────────────
$quickIndex = @'
    <!-- ÍNDICE RÁPIDO -->
    <section style="background:white;border-bottom:1px solid #e8edf4;padding:0;">
      <div style="max-width:1400px;margin:0 auto;padding:0 40px;">
        <details style="padding:20px 0;" open>
          <summary style="cursor:pointer;font-family:''Segoe UI'',system-ui,sans-serif;font-weight:700;font-size:1rem;color:#1B4B8C;list-style:none;display:flex;align-items:center;gap:8px;user-select:none;">
            <span style="background:#1B4B8C;color:white;width:22px;height:22px;border-radius:50%;display:inline-flex;align-items:center;justify-content:center;font-size:0.75rem;flex-shrink:0;">≡</span>
            Índice completo — 53 guías organizadas por tema
            <span style="margin-left:auto;font-size:0.8rem;color:#32B298;font-weight:600;">▾ colapsar</span>
          </summary>
          <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:28px;padding:24px 0 8px;">

            <div>
              <p style="font-size:0.7rem;font-weight:800;letter-spacing:.1em;text-transform:uppercase;color:#32B298;margin-bottom:10px;">🌍 Países</p>
              <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:5px;">
                <li><a href="/blog/estudiar-australia-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇦🇺 Australia 2026</a></li>
                <li><a href="/blog/estudiar-canada-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇨🇦 Canadá 2026</a></li>
                <li><a href="/blog/estudiar-irlanda-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇮🇪 Irlanda 2026</a></li>
                <li><a href="/blog/estudiar-nueva-zelanda-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇳🇿 Nueva Zelanda 2026</a></li>
                <li><a href="/blog/estudiar-reino-unido-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇬🇧 Reino Unido 2026</a></li>
                <li><a href="/blog/estudiar-malta-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇲🇹 Malta 2026</a></li>
                <li><a href="/blog/estudiar-estados-unidos-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇺🇸 Estados Unidos 2026</a></li>
                <li><a href="/blog/estudiar-dubai-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇦🇪 Dubái 2026</a></li>
                <li><a href="/blog/estudiar-alemania-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇩🇪 Alemania 2026</a></li>
                <li><a href="/blog/estudiar-francia-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">🇫🇷 Francia 2026</a></li>
              </ul>
            </div>

            <div>
              <p style="font-size:0.7rem;font-weight:800;letter-spacing:.1em;text-transform:uppercase;color:#32B298;margin-bottom:10px;">🏙️ Por Ciudad</p>
              <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:5px;">
                <li><a href="/blog/estudiar-ingles-dublin-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Dublín, Irlanda</a></li>
                <li><a href="/blog/estudiar-ingles-cork-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Cork, Irlanda</a></li>
                <li><a href="/blog/estudiar-ingles-toronto-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Toronto, Canadá</a></li>
                <li><a href="/blog/estudiar-ingles-vancouver-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Vancouver, Canadá</a></li>
                <li><a href="/blog/estudiar-ingles-sydney-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Sydney, Australia</a></li>
                <li><a href="/blog/estudiar-ingles-melbourne-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Melbourne, Australia</a></li>
                <li><a href="/blog/estudiar-ingles-auckland-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Auckland, Nueva Zelanda</a></li>
                <li><a href="/blog/estudiar-ingles-londres-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Londres, UK</a></li>
                <li><a href="/blog/estudiar-ingles-manchester-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Manchester, UK</a></li>
                <li><a href="/blog/estudiar-ingles-nueva-york-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Nueva York, USA</a></li>
              </ul>
            </div>

            <div>
              <p style="font-size:0.7rem;font-weight:800;letter-spacing:.1em;text-transform:uppercase;color:#32B298;margin-bottom:10px;">📋 Visas</p>
              <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:5px;">
                <li><a href="/blog/visa-estudiante-australia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Australia (Subcl. 500)</a></li>
                <li><a href="/blog/visa-estudiante-canada-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Study Permit Canadá</a></li>
                <li><a href="/blog/visa-estudiante-irlanda-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Irlanda (Stamp 2)</a></li>
                <li><a href="/blog/visa-estudiante-nueva-zelanda-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Nueva Zelanda</a></li>
                <li><a href="/blog/visa-estudiante-reino-unido-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Student UK</a></li>
                <li><a href="/blog/visa-estudiante-estados-unidos-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa F-1 USA</a></li>
                <li><a href="/blog/visa-estudiante-alemania-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Alemania (Visum D)</a></li>
                <li><a href="/blog/visa-estudiante-malta-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Malta / Schengen</a></li>
                <li><a href="/blog/visa-schengen-colombianos-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Schengen general</a></li>
                <li><a href="/blog/requisitos-visa-trabajo-australia-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Visa Trabajo Australia</a></li>
              </ul>
            </div>

            <div>
              <p style="font-size:0.7rem;font-weight:800;letter-spacing:.1em;text-transform:uppercase;color:#32B298;margin-bottom:10px;">⚖️ Comparativas</p>
              <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:5px;">
                <li><a href="/blog/australia-vs-canada-colombianos-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Australia vs Canadá</a></li>
                <li><a href="/blog/australia-vs-irlanda-colombianos-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Australia vs Irlanda</a></li>
                <li><a href="/blog/canada-vs-reino-unido-colombianos-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Canadá vs Reino Unido</a></li>
                <li><a href="/blog/malta-vs-irlanda-colombianos-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Malta vs Irlanda</a></li>
                <li><a href="/blog/dublin-vs-cork-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Dublín vs Cork</a></li>
                <li><a href="/blog/sydney-vs-melbourne-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Sydney vs Melbourne</a></li>
                <li><a href="/blog/toronto-vs-vancouver-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Toronto vs Vancouver</a></li>
                <li><a href="/blog/londres-vs-manchester-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Londres vs Manchester</a></li>
                <li><a href="/blog/nueva-york-vs-miami-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Nueva York vs Miami</a></li>
                <li><a href="/blog/mejor-pais-estudiar-ingles-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Mejor país para estudiar inglés</a></li>
              </ul>
            </div>

            <div>
              <p style="font-size:0.7rem;font-weight:800;letter-spacing:.1em;text-transform:uppercase;color:#32B298;margin-bottom:10px;">💡 Guías Prácticas</p>
              <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:5px;">
                <li><a href="/blog/costo-estudiar-exterior-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Cuánto cuesta estudiar afuera</a></li>
                <li><a href="/blog/trabajar-mientras-estudias-exterior.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Trabajar mientras estudias</a></li>
                <li><a href="/blog/alojamiento-estudiar-exterior-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Alojamiento en el exterior</a></li>
                <li><a href="/blog/becas-estudiar-exterior-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Becas disponibles 2026</a></li>
                <li><a href="/blog/diferencia-ielts-toefl-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">IELTS vs TOEFL</a></li>
                <li><a href="/blog/ingles-b2-cuanto-tiempo-colombia.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Tiempo para inglés B2</a></li>
                <li><a href="/blog/maestrias-exterior-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Maestrías en el exterior</a></li>
                <li><a href="/blog/como-elegir-escuela-idiomas-exterior.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Cómo elegir tu escuela</a></li>
                <li><a href="/blog/estudiar-exterior-sin-dinero-colombia-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Estudiar sin dinero</a></li>
                <li><a href="/blog/vivir-trabajar-irlanda-colombianos-2026.html" style="color:#1B4B8C;text-decoration:none;font-size:0.85rem;font-weight:500;">Vivir y trabajar en Irlanda</a></li>
              </ul>
            </div>

          </div>
        </details>
      </div>
    </section>

'@

$c = $c -replace '    <!-- BLOG GRID -->', ($quickIndex + '    <!-- BLOG GRID -->')

[System.IO.File]::WriteAllText($path, $c, $enc)
Write-Host 'Blog index updated'

# ─── 6. HOMEPAGE: Fix Malta y Dubai en Destinos Estrella ─────────────────────
$hPath = 'C:\Users\User\.claude\navia-website\index.html'
$h = [System.IO.File]::ReadAllText($hPath, $enc)

# Malta homepage: EUR 80 → 20h
$h = $h -replace '<div style="font-size:1\.8rem;font-weight:900;color:white;line-height:1;">EUR 80</div>\s*<div style="color:rgba\(255,255,255,\.82\);font-size:0\.75rem;font-weight:600;">Visa Schengen</div>', '<div style="font-size:1.8rem;font-weight:900;color:white;line-height:1;">20h</div><div style="color:rgba(255,255,255,.82);font-size:0.75rem;font-weight:600;">/semana · trabajo legal</div>'

# Malta homepage bottom
$h = $h -replace 'Trabajo inmediato · 26 países', '20h/semana · trabajo desde día 1'

# Dubai homepage: 7–10 → mantenemos (ya es correcto) pero fix badge $0
$h = $h -replace '<span style="position:absolute;top:10px;right:10px;background:white;color:#7a5018;font-size:0\.6rem;font-weight:800;padding:2px 7px;border-radius:12px;">\$0</span>', '<span style="position:absolute;top:10px;right:10px;background:white;color:#7a5018;font-size:0.6rem;font-weight:800;padding:2px 7px;border-radius:12px;">7 DÍAS</span>'

[System.IO.File]::WriteAllText($hPath, $h, $enc)
Write-Host 'Homepage updated'

Write-Host 'ALL DONE'
