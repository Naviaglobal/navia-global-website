$enc = New-Object System.Text.UTF8Encoding($false)
$blogDir = "C:\Users\User\.claude\navia-website\blog"
$a=[char]225;$e=[char]233;$i=[char]237;$o=[char]243;$u=[char]250;$n=[char]241;$eu=[char]0x20AC

function Write-Article($filename, $html) {
    $path = Join-Path $blogDir $filename
    [System.IO.File]::WriteAllText($path, $html, $enc)
    Write-Host "[OK] blog/$filename"
}

# ═══════════════════════════════════
# ARTICULO 1: Cuanto gana colombiano en Australia
# ═══════════════════════════════════
Write-Article "cuanto-gana-colombiano-australia.html" @"
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><link rel="canonical" href="https://naviaglobal.co/blog/cuanto-gana-colombiano-australia.html"><link rel="author" href="/sobre-samuel-sanchez.html"><title>${i}Cu${a}nto Gana un Colombiano en Australia 2026? Salarios Reales | Navia Global</title><meta name="description" content="${i}Cu${a}nto gana un colombiano trabajando en Australia? Salario m${i}nimo AUD `$24.95/hora, sueldos por industria y cu${a}nto puedes ahorrar siendo estudiante."><meta property="og:title" content="${i}Cu${a}nto Gana un Colombiano en Australia 2026?"><meta property="og:description" content="Salarios reales en Australia para colombianos: por hora, por semana y por mes. Datos verificados 2026."><meta property="og:type" content="article"><meta name="twitter:card" content="summary_large_image"><link rel="preconnect" href="https://fonts.googleapis.com"><link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&family=Poppins:wght@700;800&display=swap" rel="stylesheet">
<script type="application/ld+json">{"@context":"https://schema.org","@type":"Article","headline":"${i}Cu${a}nto Gana un Colombiano en Australia 2026? Salarios Reales","description":"Salarios reales en Australia para colombianos estudiantes y trabajadores. AUD 24.95/hora salario m${i}nimo, sueldos por industria.","author":{"@type":"Person","name":"Samuel S${a}nchez","url":"https://naviaglobal.co/sobre-samuel-sanchez.html","jobTitle":"Fundador Navia Global"},"publisher":{"@type":"Organization","name":"Navia Global","logo":{"@type":"ImageObject","url":"https://naviaglobal.co/logo.webp"}},"datePublished":"2026-05-12","dateModified":"2026-05-12","mainEntityOfPage":"https://naviaglobal.co/blog/cuanto-gana-colombiano-australia.html"}</script>
<script type="application/ld+json">{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Inicio","item":"https://naviaglobal.co"},{"@type":"ListItem","position":2,"name":"Blog","item":"https://naviaglobal.co/blog/"},{"@type":"ListItem","position":3,"name":"${i}Cu${a}nto gana un colombiano en Australia?","item":"https://naviaglobal.co/blog/cuanto-gana-colombiano-australia.html"}]}</script>
<script type="application/ld+json">{"@context":"https://schema.org","@type":"FAQPage","mainEntity":[{"@type":"Question","name":"${i}Cu${a}nto es el salario m${i}nimo en Australia 2026?","acceptedAnswer":{"@type":"Answer","text":"El salario m${i}nimo en Australia es AUD `$24.95 por hora (National Minimum Wage 2026). Esto equivale a aproximadamente `$72.300 pesos colombianos por hora."}},{"@type":"Question","name":"${i}Cu${a}nto gana un colombiano en Australia al mes?","acceptedAnswer":{"@type":"Answer","text":"Un colombiano trabajando a tiempo completo (38h/semana) gana AUD `$3.910/mes. Como estudiante (48h quincenales, ~24h/semana) gana AUD `$2.400/mes, equivalente a unos 7.200.000 COP."}},{"@type":"Question","name":"${i}En qu${e} trabajos ganan m${a}s los colombianos en Australia?","acceptedAnswer":{"@type":"Answer","text":"Los trabajos mejor pagados para colombianos son: construcci${o}n (AUD `$35-45/hora), miner${i}a (AUD `$40-60/hora), y tecnolog${i}a (AUD `$45-80/hora). Para estudiantes, hospitality y retail son los m${a}s accesibles (AUD `$25-30/hora)."}}]}</script>
<style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Inter',sans-serif;line-height:1.7;color:#2C3E50;background:#fff}.header{background:#1B4B8C;color:white;padding:16px 0;position:sticky;top:0;z-index:100}.header-content{max-width:1100px;margin:0 auto;padding:0 20px;display:flex;justify-content:space-between;align-items:center}.logo{display:flex;align-items:center;gap:10px;text-decoration:none;color:white;font-family:'Poppins',sans-serif;font-weight:800}.logo img{height:36px}.cta-header{background:#1ABC9C;color:white;padding:10px 22px;border-radius:25px;text-decoration:none;font-weight:700;font-size:.9rem}.hero{background:linear-gradient(135deg,#1B4B8C,#0A2463);color:white;padding:64px 20px;text-align:center}.hero h1{font-family:'Poppins',sans-serif;font-size:2.4rem;font-weight:800;line-height:1.2;margin-bottom:16px;max-width:800px;margin-left:auto;margin-right:auto}.hero .meta{display:flex;justify-content:center;gap:20px;font-size:.9rem;opacity:.85;margin-top:16px;flex-wrap:wrap}.container{max-width:820px;margin:0 auto;padding:48px 20px}.content h2{font-family:'Poppins',sans-serif;color:#0A2463;font-size:1.8rem;margin:48px 0 16px;padding-bottom:10px;border-bottom:3px solid #1ABC9C}.content h3{color:#1B4B8C;font-size:1.3rem;margin:32px 0 12px}.content p{margin:16px 0;font-size:1.05rem}.content ul,.content ol{margin:16px 0;padding-left:28px}.content li{margin:8px 0;font-size:1rem}table{width:100%;border-collapse:collapse;margin:24px 0;box-shadow:0 2px 8px rgba(0,0,0,.06)}th{background:#1B4B8C;color:white;padding:13px 16px;text-align:left;font-weight:600}td{padding:13px 16px;border-bottom:1px solid #e8e8e8}tr:nth-child(even){background:#f8faff}.highlight{background:#FFF9E6;border-left:5px solid #F59E0B;padding:20px 24px;margin:24px 0;border-radius:8px}.highlight h4{color:#0A2463;margin-bottom:10px;font-size:1.1rem}.info{background:#E8F5F7;border-left:5px solid #1ABC9C;padding:20px 24px;margin:24px 0;border-radius:8px}.cta-box{background:linear-gradient(135deg,#1ABC9C,#16A085);color:white;padding:36px;margin:40px 0;border-radius:14px;text-align:center}.cta-box h3{font-size:1.7rem;margin-bottom:10px}.cta-box p{opacity:.95;margin-bottom:20px}.cta-button{background:white;color:#16A085;padding:14px 36px;border-radius:30px;text-decoration:none;font-weight:800;font-size:1rem;display:inline-block}.footer{background:#0A2463;color:rgba(255,255,255,.8);padding:36px 20px;text-align:center}.wa-float{position:fixed;bottom:28px;right:28px;width:56px;height:56px;background:#25D366;border-radius:50%;display:flex;align-items:center;justify-content:center;text-decoration:none;box-shadow:0 4px 16px rgba(37,211,102,.4);z-index:999}@media(max-width:768px){.hero h1{font-size:1.8rem}.container{padding:32px 16px}}</style>
</head><body>
<header class="header"><div class="header-content"><a href="/" class="logo"><img src="/logo.webp" alt="Navia Global">Navia Global</a><a href="https://wa.me/573014430722?text=Hola,%20quiero%20informaci${o}n%20para%20estudiar%20en%20Australia" class="cta-header">Asesor${i}a Gratis</a></div></header>
<nav style="background:rgba(10,36,99,.95);padding:8px 0"><div style="max-width:1100px;margin:0 auto;padding:0 20px;font-size:.8rem;color:rgba(255,255,255,.7)"><a href="/" style="color:rgba(255,255,255,.7);text-decoration:none">Inicio</a> / <a href="/blog/" style="color:rgba(255,255,255,.7);text-decoration:none">Blog</a> / <span style="color:white">${i}Cu${a}nto gana un colombiano en Australia?</span></div></nav>
<section class="hero"><h1>${i}Cu${a}nto Gana un Colombiano en Australia 2026?</h1><p style="font-size:1.1rem;opacity:.92;max-width:600px;margin:0 auto">Salarios reales por industria, cu${a}nto puedes ganar como estudiante y c${o}mo compararlo con Colombia.</p><div class="meta"><span>📅 Mayo 2026</span><span>⏱️ 8 min</span><span>👤 Samuel S${a}nchez</span></div></section>
<div class="container"><div style="background:#f0fdf8;border-left:4px solid #1ABC9C;border-radius:8px;padding:16px 20px;margin-bottom:32px;font-size:.95rem;color:#2C3E50"><strong style="color:#0A2463">Verificado por Samuel S${a}nchez</strong>, fundador de Navia Global, asesor certificado British Council (N° 108268). Datos salariales de Fair Work Australia, actualizados mayo 2026.</div>
<div class="content">
<p>La pregunta que m${a}s nos hacen en Navia Global antes de que alguien decida irse a Australia es siempre la misma: <strong>${i}cu${a}nto voy a ganar?</strong> En esta gu${i}a te damos n${u}meros reales, no estimaciones optimistas.</p>

<h2>Salario M${i}nimo en Australia 2026</h2>
<p>El salario m${i}nimo nacional en Australia (National Minimum Wage) para 2026 es <strong>AUD `$24.95 por hora</strong>. Esto aplica para todos los trabajadores, incluidos estudiantes internacionales.</p>
<div class="highlight"><h4>💱 Equivalencia en pesos colombianos</h4><p>AUD `$24.95/hora ≈ <strong>`$72.300 COP por hora</strong> (tasa mayo 2026: 1 AUD ≈ `$2.900 COP)</p><p>Compara con Colombia: `$6.250 COP/hora (salario m${i}nimo colombiano 2026)</p><p><strong>Australia paga 11.5 veces m${a}s por hora que Colombia.</strong></p></div>

<h2>Ingresos Reales como Estudiante Colombiano</h2>
<p>Como estudiante con visa subclase 500 puedes trabajar <strong>48 horas quincenales</strong> (≈24h/semana) durante clases y tiempo completo en vacaciones.</p>
<table><thead><tr><th>Escenario</th><th>Horas/semana</th><th>AUD/semana</th><th>AUD/mes</th><th>COP/mes</th></tr></thead><tbody>
<tr><td>Estudiante (clases)</td><td>24h</td><td>`$599</td><td>`$2.396</td><td>~`$6.950.000</td></tr>
<tr><td>Estudiante (vacaciones)</td><td>38-40h</td><td>`$948</td><td>`$3.792</td><td>~`$11.000.000</td></tr>
<tr><td>Trabajador tiempo completo</td><td>38h</td><td>`$948</td><td>`$3.792</td><td>~`$11.000.000</td></tr>
</tbody></table>

<h2>Salarios por Industria (Lo Que Consiguen los Colombianos)</h2>
<table><thead><tr><th>Industria</th><th>AUD/hora</th><th>Perfil t${i}pico</th></tr></thead><tbody>
<tr><td>Hospitality (mesero, barista)</td><td>`$25-32</td><td>Nivel B1 ingl${e}s m${i}nimo</td></tr>
<tr><td>Retail (cajero, vendedor)</td><td>`$25-28</td><td>Sin experiencia previa</td></tr>
<tr><td>Limpieza / Cleaning</td><td>`$26-30</td><td>F${a}cil conseguir, muy demandado</td></tr>
<tr><td>Construcci${o}n / Landscaping</td><td>`$30-45</td><td>Experiencia previa ayuda</td></tr>
<tr><td>Cuidado de ni${n}os (Nanny)</td><td>`$25-35</td><td>Ingl${e}s intermedio</td></tr>
<tr><td>Tecnolog${i}a / IT</td><td>`$45-80</td><td>T${i}tulo o experiencia requerida</td></tr>
<tr><td>Uber Eats / Deliveroo</td><td>`$15-25*</td><td>Bicicleta o auto propio</td></tr>
</tbody></table>
<p style="font-size:.85rem;color:#666">*Delivery: ingresos variables seg${u}n zona y horario. Fines de semana y noches son m${a}s rentables.</p>

<h2>Balance Real: Ingresos vs Gastos Mensuales</h2>
<div class="highlight"><h4>📊 Ejemplo real: estudiante en Melbourne trabajando 24h/semana</h4>
<table><thead><tr><th>Concepto</th><th>AUD/mes</th></tr></thead><tbody>
<tr><td><strong>Ingresos (24h × AUD 27/hora × 4 semanas)</strong></td><td><strong>+`$2.592</strong></td></tr>
<tr><td>Alojamiento (piso compartido)</td><td>-`$900</td></tr>
<tr><td>Comida</td><td>-`$500</td></tr>
<tr><td>Transporte</td><td>-`$160</td></tr>
<tr><td>Tel${e}fono / internet</td><td>-`$60</td></tr>
<tr><td>Ocio y extras</td><td>-`$200</td></tr>
<tr style="background:#e8fdf5"><td><strong>AHORRO MENSUAL</strong></td><td><strong>+`$772 AUD (~`$2.240.000 COP)</strong></td></tr>
</tbody></table></div>

<h2>${i}Pagan Impuestos los Colombianos en Australia?</h2>
<p><strong>S${i}.</strong> Australia tiene un sistema tributario progresivo. Los estudiantes internacionales pagan impuestos como cualquier residente:</p>
<ul>
<li>Ingresos hasta AUD `$18.200/a${n}o: <strong>0% de impuesto</strong></li>
<li>AUD `$18.201 - `$45.000: <strong>19 centavos por cada d${o}lar sobre `$18.200</strong></li>
<li>Para estudiantes (24h/sem): ingresos anuales ≈ `$29.000 AUD → impuesto ≈ `$2.052 AUD/a${n}o</li>
</ul>
<div class="info"><h4>💡 Tax File Number (TFN)</h4><p>Debes sacar tu TFN (Tax File Number) apenas llegues a Australia. Sin TFN, tu empleador descuenta el <strong>47% de tu salario</strong> en retenci${o}n. Con TFN, pagas la tasa normal seg${u}n tus ingresos. Es gr${a}tis y se tramita online en menos de 30 minutos.</p></div>

<h2>Superannuation: El Bono Extra que Muchos No Conocen</h2>
<p>Australia obliga a los empleadores a aportar un <strong>11.5% adicional de tu salario</strong> a un fondo de pensiones llamado Superannuation. Si te vas de Australia, puedes reclamar ese dinero de regreso.</p>
<p>Ejemplo: ganando AUD `$2.400/mes → tu empleador aporta AUD `$276/mes a Super → en 6 meses acumulas ≈ <strong>AUD `$1.656 que puedes reclamar al salir del pa${i}s.</strong></p>

<h2>Comparativa Definitiva: Australia vs Colombia</h2>
<table><thead><tr><th>Indicador</th><th>Australia 🇦🇺</th><th>Colombia 🇨🇴</th></tr></thead><tbody>
<tr><td>Salario m${i}nimo/hora</td><td>AUD `$24.95 (~`$72.000 COP)</td><td>`$6.250 COP</td></tr>
<tr><td>Salario mesero/a</td><td>AUD `$28/hora (~`$81.000 COP)</td><td>`$8.000-15.000 COP/hora</td></tr>
<tr><td>Alquiler cuarto compartido</td><td>AUD `$900/mes</td><td>`$700.000-1.200.000 COP/mes</td></tr>
<tr><td>Comida mensual</td><td>AUD `$500/mes</td><td>`$400.000-700.000 COP/mes</td></tr>
<tr><td>Capacidad de ahorro mensual</td><td>AUD `$700-1.000</td><td>`$0-300.000 COP</td></tr>
</tbody></table>

<div class="cta-box"><h3>¿Listo para ir a Australia?</h3><p>Navia Global te asesora gratis. Te decimos qu${e} escuela, qu${e} ciudad y c${o}mo maximizar tus ingresos desde el primer mes.</p><a href="https://wa.me/573014430722?text=Hola,%20quiero%20saber%20cuanto%20puedo%20ganar%20en%20Australia" class="cta-button">Calcular mis ingresos potenciales</a></div>

<h2>Preguntas Frecuentes</h2>
<div style="border-bottom:1px solid #e0e0e0;padding:20px 0"><h3 style="color:#1B4B8C;margin-bottom:8px">${i}Cu${a}nto gana un colombiano en Australia al mes en 2026?</h3><p>Como estudiante (24h/semana): AUD `$2.400/mes (~`$7M COP). Tiempo completo: AUD `$3.800/mes (~`$11M COP).</p></div>
<div style="border-bottom:1px solid #e0e0e0;padding:20px 0"><h3 style="color:#1B4B8C;margin-bottom:8px">${i}Se puede ahorrar dinero estudiando en Australia?</h3><p>S${i}. La mayor${i}a de estudiantes colombianos ahorran AUD `$500-1.000/mes despu${e}s de cubrir todos sus gastos.</p></div>
<div style="padding:20px 0"><h3 style="color:#1B4B8C;margin-bottom:8px">${i}Cu${a}ndo puedo empezar a trabajar en Australia?</h3><p>Puedes trabajar desde que empiece tu curso (no antes). Normalmente los estudiantes consiguen trabajo en las primeras 2-4 semanas de llegada.</p></div>

<p>📖 Lee tambi${e}n: <a href="/blog/estudiar-australia-colombia-2026.html" style="color:#1B4B8C;font-weight:600">Gu${i}a completa para estudiar en Australia desde Colombia</a></p>
</div></div>
<footer class="footer"><p>© 2026 Navia Global | <a href="/" style="color:rgba(255,255,255,.7)">Inicio</a> · <a href="/blog/" style="color:rgba(255,255,255,.7)">Blog</a> · <a href="/contacto.html" style="color:rgba(255,255,255,.7)">Contacto</a></p></footer>
<a href="https://wa.me/573014430722" class="wa-float" target="_blank" rel="noopener" aria-label="WhatsApp"><svg width="28" height="28" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg></a>
</body></html>
"@

# ═══════════════════════════════════
# ARTICULO 2: Diferencia visa estudiante vs working holiday
# ═══════════════════════════════════
Write-Article "diferencia-visa-estudiante-working-holiday.html" @"
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><link rel="canonical" href="https://naviaglobal.co/blog/diferencia-visa-estudiante-working-holiday.html"><link rel="author" href="/sobre-samuel-sanchez.html"><title>Visa Estudiante vs Working Holiday Australia: ${i}Cu${a}l Elegir? 2026 | Navia Global</title><meta name="description" content="Diferencias reales entre visa de estudiante (subclase 500) y Working Holiday (subclase 417) para colombianos en Australia 2026. Costos, restricciones y cu${a}l te conviene."><meta property="og:title" content="Visa Estudiante vs Working Holiday Australia 2026"><meta property="og:type" content="article"><meta name="twitter:card" content="summary_large_image"><link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&family=Poppins:wght@700;800&display=swap" rel="stylesheet">
<script type="application/ld+json">{"@context":"https://schema.org","@type":"Article","headline":"Visa Estudiante vs Working Holiday Australia: ${i}Cu${a}l Elegir?","author":{"@type":"Person","name":"Samuel S${a}nchez","url":"https://naviaglobal.co/sobre-samuel-sanchez.html","jobTitle":"Fundador Navia Global"},"publisher":{"@type":"Organization","name":"Navia Global","logo":{"@type":"ImageObject","url":"https://naviaglobal.co/logo.webp"}},"datePublished":"2026-05-12","dateModified":"2026-05-12"}</script>
<script type="application/ld+json">{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Inicio","item":"https://naviaglobal.co"},{"@type":"ListItem","position":2,"name":"Blog","item":"https://naviaglobal.co/blog/"},{"@type":"ListItem","position":3,"name":"Visa Estudiante vs Working Holiday","item":"https://naviaglobal.co/blog/diferencia-visa-estudiante-working-holiday.html"}]}</script>
<script type="application/ld+json">{"@context":"https://schema.org","@type":"FAQPage","mainEntity":[{"@type":"Question","name":"${i}Pueden los colombianos sacar Working Holiday en Australia?","acceptedAnswer":{"@type":"Answer","text":"S${i}. Colombia est${a} incluida en el acuerdo de Working Holiday con Australia desde 2023. Debes tener entre 18 y 35 a${n}os. La visa (subclase 462) permite trabajar y estudiar hasta 4 meses."}},{"@type":"Question","name":"${i}Cu${a}l es mejor: visa estudiante o Working Holiday para Colombia?","acceptedAnswer":{"@type":"Answer","text":"Depende de tu objetivo. Si quieres estudiar idiomas m${a}s de 4 meses, visa estudiante (500). Si quieres trabajar libremente m${a}s que estudiar, Working Holiday (462). Muchos colombianos hacen ambas: empiezan con Working Holiday y luego pasan a visa estudiante."}},{"@type":"Question","name":"${i}Cu${a}nto cuesta la Working Holiday visa para colombianos?","acceptedAnswer":{"@type":"Answer","text":"La Work and Holiday visa (subclase 462) cuesta AUD 635 (2026). La visa de estudiante (subclase 500) cuesta AUD 1.600-2.000 seg${u}n el tipo de curso."}}]}</script>
<style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Inter',sans-serif;line-height:1.7;color:#2C3E50;background:#fff}.header{background:#1B4B8C;color:white;padding:16px 0;position:sticky;top:0;z-index:100}.header-content{max-width:1100px;margin:0 auto;padding:0 20px;display:flex;justify-content:space-between;align-items:center}.logo{display:flex;align-items:center;gap:10px;text-decoration:none;color:white;font-family:'Poppins',sans-serif;font-weight:800}.logo img{height:36px}.cta-header{background:#1ABC9C;color:white;padding:10px 22px;border-radius:25px;text-decoration:none;font-weight:700;font-size:.9rem}.hero{background:linear-gradient(135deg,#0A2463,#1B4B8C);color:white;padding:64px 20px;text-align:center}.hero h1{font-family:'Poppins',sans-serif;font-size:2.3rem;font-weight:800;line-height:1.2;margin-bottom:16px;max-width:800px;margin-left:auto;margin-right:auto}.hero .meta{display:flex;justify-content:center;gap:20px;font-size:.9rem;opacity:.85;margin-top:16px;flex-wrap:wrap}.container{max-width:820px;margin:0 auto;padding:48px 20px}.content h2{font-family:'Poppins',sans-serif;color:#0A2463;font-size:1.8rem;margin:48px 0 16px;padding-bottom:10px;border-bottom:3px solid #1ABC9C}.content h3{color:#1B4B8C;font-size:1.3rem;margin:28px 0 10px}.content p{margin:16px 0;font-size:1.05rem}.content ul{margin:16px 0;padding-left:28px}.content li{margin:8px 0;font-size:1rem}table{width:100%;border-collapse:collapse;margin:24px 0}th{background:#1B4B8C;color:white;padding:13px 16px;text-align:left}td{padding:13px 16px;border-bottom:1px solid #e8e8e8}tr:nth-child(even){background:#f8faff}.highlight{background:#FFF9E6;border-left:5px solid #F59E0B;padding:20px 24px;margin:24px 0;border-radius:8px}.highlight h4{color:#0A2463;margin-bottom:10px}.info{background:#E8F5F7;border-left:5px solid #1ABC9C;padding:20px 24px;margin:24px 0;border-radius:8px}.warn{background:#FFF3E0;border-left:5px solid #FF9800;padding:20px 24px;margin:24px 0;border-radius:8px}.cta-box{background:linear-gradient(135deg,#1ABC9C,#16A085);color:white;padding:36px;margin:40px 0;border-radius:14px;text-align:center}.cta-box h3{font-size:1.7rem;margin-bottom:10px}.cta-box p{opacity:.95;margin-bottom:20px}.cta-button{background:white;color:#16A085;padding:14px 36px;border-radius:30px;text-decoration:none;font-weight:800;font-size:1rem;display:inline-block}.footer{background:#0A2463;color:rgba(255,255,255,.8);padding:36px 20px;text-align:center}.wa-float{position:fixed;bottom:28px;right:28px;width:56px;height:56px;background:#25D366;border-radius:50%;display:flex;align-items:center;justify-content:center;text-decoration:none;box-shadow:0 4px 16px rgba(37,211,102,.4);z-index:999}@media(max-width:768px){.hero h1{font-size:1.7rem}}</style>
</head><body>
<header class="header"><div class="header-content"><a href="/" class="logo"><img src="/logo.webp" alt="Navia Global">Navia Global</a><a href="https://wa.me/573014430722" class="cta-header">Asesor${i}a Gratis</a></div></header>
<nav style="background:rgba(10,36,99,.95);padding:8px 0"><div style="max-width:1100px;margin:0 auto;padding:0 20px;font-size:.8rem;color:rgba(255,255,255,.7)"><a href="/" style="color:rgba(255,255,255,.7);text-decoration:none">Inicio</a> / <a href="/blog/" style="color:rgba(255,255,255,.7);text-decoration:none">Blog</a> / <span style="color:white">Visa estudiante vs Working Holiday</span></div></nav>
<section class="hero"><h1>Visa Estudiante vs Working Holiday en Australia: ${i}Cu${a}l Elegir?</h1><p style="font-size:1.05rem;opacity:.92;max-width:600px;margin:0 auto">Comparativa completa para colombianos: diferencias reales, costos y qui${e}n deber${i}a elegir cada una.</p><div class="meta"><span>📅 Mayo 2026</span><span>⏱️ 9 min</span><span>👤 Samuel S${a}nchez</span></div></section>
<div class="container"><div class="content">
<p>Esta es una de las consultas m${a}s frecuentes que recibimos: <strong>${i}me conviene m${a}s la visa de estudiante o la Working Holiday?</strong> La respuesta depende completamente de tu perfil y objetivos. Aqu${i} te explicamos todo.</p>

<h2>La Diferencia Fundamental</h2>
<table><thead><tr><th>Caracter${i}stica</th><th>Visa Estudiante (500)</th><th>Work & Holiday (462)</th></tr></thead><tbody>
<tr><td>Objetivo principal</td><td>Estudiar</td><td>Trabajar y viajar</td></tr>
<tr><td>Costo</td><td>AUD `$1.600-2.000</td><td>AUD `$635</td></tr>
<tr><td>Requisito de edad</td><td>Sin l${i}mite</td><td>18-35 a${n}os</td></tr>
<tr><td>Duraci${o}n</td><td>Seg${u}n el curso</td><td>12 meses</td></tr>
<tr><td>Horas de trabajo</td><td>48h quincenales</td><td>Sin l${i}mite de horas</td></tr>
<tr><td>Estudio permitido</td><td>Ilimitado</td><td>M${a}ximo 4 meses</td></tr>
<tr><td>Mismo empleador</td><td>Sin restricci${o}n</td><td>M${a}x 6 meses por empleador</td></tr>
<tr><td>Renovable</td><td>S${i} (con nuevo curso)</td><td>S${i} (con trabajo regional)</td></tr>
</tbody></table>

<h2>Working Holiday para Colombianos: Lo Que Cambi${o}</h2>
<p>Desde 2023, Colombia est${a} incluida en el programa Work and Holiday de Australia (<strong>subclase 462</strong>). Esto es relativamente nuevo y muchos colombianos a${u}n no lo saben.</p>
<div class="info"><h4>📋 Requisitos Working Holiday (subclase 462) para colombianos</h4><ul><li>Pasaporte colombiano v${a}lido</li><li>Edad: 18-35 a${n}os al momento de aplicar</li><li>Carta de endoso del gobierno colombiano (Ministerio de Relaciones Exteriores)</li><li>Sin hijos dependientes viajando contigo</li><li>Fondo demostrable m${i}nimo: AUD `$5.000</li><li>Sin antecedentes penales</li></ul></div>

<div class="warn"><h4>⚠️ La carta de endoso es el paso m${a}s complicado</h4><p>Colombia tiene un cupo anual de visas Work and Holiday. Debes solicitar primero la carta de endoso al Ministerio de Relaciones Exteriores de Colombia antes de aplicar a la visa australiana. Navia Global te ayuda en este proceso.</p></div>

<h2>${i}Cu${a}ndo Elegir Cada Una?</h2>
<h3>Elige Visa de Estudiante (500) si:</h3>
<ul>
<li>Quieres estudiar ingl${e}s por m${a}s de 4 meses</li>
<li>Tienes m${a}s de 35 a${n}os</li>
<li>Quieres estabilidad: mismo empleador por el tiempo que quieras</li>
<li>Buscas hacer carrera o t${i}tulo vocacional</li>
<li>Tu pareja quiere acompa${n}arte como dependiente</li>
</ul>
<h3>Elige Working Holiday (462) si:</h3>
<ul>
<li>Tienes entre 18 y 35 a${n}os</li>
<li>Quieres m${a}xima flexibilidad laboral (sin l${i}mite de horas)</li>
<li>Prefieres viajar por Australia y cambiar de ciudad</li>
<li>Tu objetivo es experiencia laboral m${a}s que estudiar</li>
<li>Quieres ahorrar m${a}s desde el primer mes</li>
</ul>

<div class="highlight"><h4>💡 La estrategia que m${a}s usan los colombianos en 2026</h4><p><strong>Empezar con Working Holiday → luego pasar a visa de estudiante.</strong></p><p>Con WHV trabajas sin restricci${o}n de horas, ahorras, y cuando ya est${a}s establecido en Australia aplicas a un curso y cambias a visa de estudiante para estudiar y seguir trabajando.</p></div>

<h2>Costos Comparados en Detalle</h2>
<table><thead><tr><th>Concepto</th><th>Visa Estudiante</th><th>Working Holiday</th></tr></thead><tbody>
<tr><td>Costo de visa</td><td>AUD `$1.600-2.000</td><td>AUD `$635</td></tr>
<tr><td>Seguro m${e}dico obligatorio</td><td>OSHC: AUD `$500-700/a${n}o</td><td>No obligatorio (recomendado)</td></tr>
<tr><td>Matr${i}cula del curso</td><td>Requerida</td><td>No requerida</td></tr>
<tr><td>Costo total para aplicar</td><td>AUD `$5.000-10.000</td><td>AUD `$1.500-3.000</td></tr>
</tbody></table>

<div class="cta-box"><h3>¿No sabes cu${a}l visa te conviene?</h3><p>En Navia Global analizamos tu perfil y te recomendamos la mejor estrategia. Completamente gratis.</p><a href="https://wa.me/573014430722?text=Hola,%20no%20s${e}%20si%20elegir%20visa%20estudiante%20o%20working%20holiday" class="cta-button">Consultar gratis por WhatsApp</a></div>

<p>📖 Lee tambi${e}n: <a href="/blog/visa-estudiante-australia-2026.html" style="color:#1B4B8C;font-weight:600">Gu${i}a completa visa de estudiante Australia 2026</a></p>
</div></div>
<footer class="footer"><p>© 2026 Navia Global | <a href="/" style="color:rgba(255,255,255,.7)">Inicio</a> · <a href="/blog/" style="color:rgba(255,255,255,.7)">Blog</a> · <a href="/contacto.html" style="color:rgba(255,255,255,.7)">Contacto</a></p></footer>
<a href="https://wa.me/573014430722" class="wa-float" target="_blank" rel="noopener" aria-label="WhatsApp"><svg width="28" height="28" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg></a>
</body></html>
"@

# ═══════════════════════════════════
# ARTICULO 3: Estudiar en Alemania gratis colombianos
# ═══════════════════════════════════
Write-Article "estudiar-gratis-alemania-colombianos.html" @"
<!DOCTYPE html><html lang="es"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><link rel="canonical" href="https://naviaglobal.co/blog/estudiar-gratis-alemania-colombianos.html"><link rel="author" href="/sobre-samuel-sanchez.html"><title>Estudiar Gratis en Alemania desde Colombia 2026: Es Real | Navia Global</title><meta name="description" content="Las universidades p${u}blicas alemanas NO cobran matr${i}cula a extranjeros. Gu${i}a completa para colombianos: requisitos de alem${a}n, proceso y costos reales 2026."><meta property="og:title" content="Estudiar Gratis en Alemania desde Colombia 2026"><meta property="og:type" content="article"><meta name="twitter:card" content="summary_large_image"><link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&family=Poppins:wght@700;800&display=swap" rel="stylesheet">
<script type="application/ld+json">{"@context":"https://schema.org","@type":"Article","headline":"Estudiar Gratis en Alemania desde Colombia 2026","author":{"@type":"Person","name":"Samuel S${a}nchez","url":"https://naviaglobal.co/sobre-samuel-sanchez.html","jobTitle":"Fundador Navia Global"},"publisher":{"@type":"Organization","name":"Navia Global","logo":{"@type":"ImageObject","url":"https://naviaglobal.co/logo.webp"}},"datePublished":"2026-05-12","dateModified":"2026-05-12"}</script>
<script type="application/ld+json">{"@context":"https://schema.org","@type":"FAQPage","mainEntity":[{"@type":"Question","name":"${i}Es verdad que en Alemania se puede estudiar gratis?","acceptedAnswer":{"@type":"Answer","text":"S${i}. Las universidades p${u}blicas alemanas (Staatliche Universit${a}ten) no cobran matr${i}cula a estudiantes extranjeros, incluidos colombianos. Solo se paga un semesterbeitrag (contribuci${o}n semestral) de EUR 150-350 que incluye transporte p${u}blico."}},{"@type":"Question","name":"${i}Qu${e} nivel de alem${a}n necesito para estudiar en Alemania?","acceptedAnswer":{"@type":"Answer","text":"Para programas en alem${a}n: nivel B2-C1 (TestDaF o DSH). Para programas en ingl${e}s: IELTS 6.0-6.5 o TOEFL 80+. Muchas universidades ofrecen masters completamente en ingl${e}s sin requerir alem${a}n."}},{"@type":"Question","name":"${i}Cu${a}nto cuesta vivir en Alemania siendo estudiante colombiano?","acceptedAnswer":{"@type":"Answer","text":"El costo de vida estimado es EUR 900-1.200/mes incluyendo alojamiento (EUR 400-700), comida (EUR 200-300), transporte (incluido en semesterbeitrag) y otros gastos. Trabajando 20h/semana (EUR 12.82/hora) cubres todos los gastos."}},{"@type":"Question","name":"${i}Puedo trabajar en Alemania con visa de estudiante?","acceptedAnswer":{"@type":"Answer","text":"S${i}. Con visa de estudiante en Alemania puedes trabajar 20 horas semanales durante el semestre y tiempo completo en vacaciones. El salario m${i}nimo es EUR 12.82/hora."}}]}</script>
<style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Inter',sans-serif;line-height:1.7;color:#2C3E50;background:#fff}.header{background:#1B4B8C;color:white;padding:16px 0;position:sticky;top:0;z-index:100}.header-content{max-width:1100px;margin:0 auto;padding:0 20px;display:flex;justify-content:space-between;align-items:center}.logo{display:flex;align-items:center;gap:10px;text-decoration:none;color:white;font-family:'Poppins',sans-serif;font-weight:800}.logo img{height:36px}.cta-header{background:#1ABC9C;color:white;padding:10px 22px;border-radius:25px;text-decoration:none;font-weight:700;font-size:.9rem}.hero{background:linear-gradient(135deg,#1a1a1a,#333);color:white;padding:64px 20px;text-align:center}.hero h1{font-family:'Poppins',sans-serif;font-size:2.3rem;font-weight:800;line-height:1.2;margin-bottom:16px;max-width:800px;margin-left:auto;margin-right:auto}.hero .meta{display:flex;justify-content:center;gap:20px;font-size:.9rem;opacity:.85;margin-top:16px;flex-wrap:wrap}.container{max-width:820px;margin:0 auto;padding:48px 20px}.content h2{font-family:'Poppins',sans-serif;color:#0A2463;font-size:1.8rem;margin:48px 0 16px;padding-bottom:10px;border-bottom:3px solid #1ABC9C}.content h3{color:#1B4B8C;font-size:1.3rem;margin:28px 0 10px}.content p{margin:16px 0;font-size:1.05rem}.content ul,.content ol{margin:16px 0;padding-left:28px}.content li{margin:8px 0;font-size:1rem}table{width:100%;border-collapse:collapse;margin:24px 0}th{background:#1B4B8C;color:white;padding:13px 16px;text-align:left}td{padding:13px 16px;border-bottom:1px solid #e8e8e8}tr:nth-child(even){background:#f8faff}.highlight{background:#FFF9E6;border-left:5px solid #F59E0B;padding:20px 24px;margin:24px 0;border-radius:8px}.highlight h4{color:#0A2463;margin-bottom:10px}.info{background:#E8F5F7;border-left:5px solid #1ABC9C;padding:20px 24px;margin:24px 0;border-radius:8px}.cta-box{background:linear-gradient(135deg,#1ABC9C,#16A085);color:white;padding:36px;margin:40px 0;border-radius:14px;text-align:center}.cta-box h3{font-size:1.7rem;margin-bottom:10px}.cta-box p{opacity:.95;margin-bottom:20px}.cta-button{background:white;color:#16A085;padding:14px 36px;border-radius:30px;text-decoration:none;font-weight:800;font-size:1rem;display:inline-block}.footer{background:#0A2463;color:rgba(255,255,255,.8);padding:36px 20px;text-align:center}.wa-float{position:fixed;bottom:28px;right:28px;width:56px;height:56px;background:#25D366;border-radius:50%;display:flex;align-items:center;justify-content:center;text-decoration:none;box-shadow:0 4px 16px rgba(37,211,102,.4);z-index:999}@media(max-width:768px){.hero h1{font-size:1.7rem}}</style>
</head><body>
<header class="header"><div class="header-content"><a href="/" class="logo"><img src="/logo.webp" alt="Navia Global">Navia Global</a><a href="https://wa.me/573014430722" class="cta-header">Asesor${i}a Gratis</a></div></header>
<nav style="background:rgba(10,36,99,.95);padding:8px 0"><div style="max-width:1100px;margin:0 auto;padding:0 20px;font-size:.8rem;color:rgba(255,255,255,.7)"><a href="/" style="color:rgba(255,255,255,.7);text-decoration:none">Inicio</a> / <a href="/blog/" style="color:rgba(255,255,255,.7);text-decoration:none">Blog</a> / <span style="color:white">Estudiar gratis en Alemania</span></div></nav>
<section class="hero"><h1>Estudiar Gratis en Alemania desde Colombia: La Gu${i}a Real 2026</h1><p style="font-size:1.05rem;opacity:.92;max-width:600px;margin:0 auto">S${i}, es verdad. Las universidades p${u}blicas alemanas no cobran matr${i}cula. Te explicamos exactamente c${o}mo hacerlo.</p><div class="meta"><span>📅 Mayo 2026</span><span>⏱️ 10 min</span><span>👤 Samuel S${a}nchez</span></div></section>
<div class="container"><div class="content">
<p>Cuando decimos que en Alemania se puede estudiar gratis, la reacci${o}n habitual es incredulidad. Pero es completamente cierto: las <strong>universidades p${u}blicas alemanas no cobran matr${i}cula</strong> a estudiantes extranjeros, incluidos colombianos.</p>

<h2>La Realidad: ${i}Qu${e} es Gratis y Qu${e} No?</h2>
<div class="highlight"><h4>✅ Lo que NO pagas en Alemania (universidades p${u}blicas)</h4><ul><li>Matr${i}cula del semestre: <strong>${eu}0</strong></li><li>Inscripci${o}n: <strong>${eu}0</strong></li><li>Uso de bibliotecas y laboratorios: <strong>${eu}0</strong></li></ul></div>
<div class="info"><h4>💶 Lo que SÍ pagas: Semesterbeitrag</h4><p>Cada semestre pagas una contribuci${o}n estudiantil de <strong>${eu}150-350</strong> (var${i}a por universidad). Esto incluye:</p><ul><li>Transporte p${u}blico ilimitado en el estado</li><li>Membres${i}a del sindicato estudiantil</li><li>Acceso a comedores universitarios (precios subsidiados: ${eu}2-4 por almuerzo)</li></ul></div>

<h2>Requisitos para Colombianos</h2>
<h3>Opci${o}n A: Estudiar en alem${a}n</h3>
<ul>
<li>Nivel de alem${a}n: <strong>B2-C1</strong> (TestDaF nivel 4 o DSH-2)</li>
<li>T${i}tulo universitario previo (para maestr${i}a) o bachillerato homologado (pregrado)</li>
<li>Promedio acad${e}mico: generalmente 3.0-4.0 sobre 5.0 colombiano</li>
</ul>
<h3>Opci${o}n B: Maestr${i}as en ingl${e}s (sin alem${a}n)</h3>
<ul>
<li>IELTS 6.0-6.5 o TOEFL 80-90</li>
<li>T${i}tulo universitario afin</li>
<li>Carta de motivaci${o}n s${o}lida</li>
</ul>
<div class="highlight"><h4>🎓 Universidades alemanas con programas en ingl${e}s para colombianos</h4>
<table><thead><tr><th>Universidad</th><th>Ciudad</th><th>Enfoque</th></tr></thead><tbody>
<tr><td>TU M${u}nchen (TUM)</td><td>M${u}nich</td><td>Ingenier${i}a, Tecnolog${i}a</td></tr>
<tr><td>Ludwig Maximilian (LMU)</td><td>M${u}nich</td><td>Humanidades, Ciencias</td></tr>
<tr><td>Humboldt Universit${a}t</td><td>Berl${i}n</td><td>Ciencias Sociales, Derecho</td></tr>
<tr><td>Freie Universit${a}t Berlin</td><td>Berl${i}n</td><td>Multidisciplinario</td></tr>
<tr><td>Heidelberg</td><td>Heidelberg</td><td>Medicina, Humanidades</td></tr>
<tr><td>RWTH Aachen</td><td>Aachen</td><td>Ingenier${i}a, TI</td></tr>
</tbody></table></div>

<h2>Ruta Inteligente para Colombianos: Primero Idioma, Luego Universidad</h2>
<p>La estrategia que recomienda Navia Global para colombianos que quieren estudiar en Alemania:</p>
<ol>
<li><strong>A${n}o 1:</strong> Curso intensivo de alem${a}n en Colombia (hasta nivel B1)</li>
<li><strong>A${n}o 2:</strong> Curso de alem${a}n en Alemania + trabaja 20h/sem → mejora al C1 mientras te financias</li>
<li><strong>A${n}o 3+:</strong> Ingresas a la universidad sin pagar matr${i}cula</li>
</ol>
<p>Con Navia Global puedes empezar por el <a href="/blog/estudiar-alemania-colombia-2026.html" style="color:#1B4B8C;font-weight:600">curso de alem${a}n en Alemania</a> (EUR 4.000 por 6 meses) mientras preparas tu aplicaci${o}n universitaria.</p>

<h2>Costo Real de Vivir y Estudiar en Alemania</h2>
<table><thead><tr><th>Gasto mensual</th><th>EUR/mes</th><th>COP/mes (approx)</th></tr></thead><tbody>
<tr><td>Alojamiento (Studentenwohnheim o piso)</td><td>${eu}350-700</td><td>1.500.000-3.000.000</td></tr>
<tr><td>Comida</td><td>${eu}200-300</td><td>860.000-1.290.000</td></tr>
<tr><td>Transporte (incluido en semesterbeitrag)</td><td>${eu}0</td><td>0</td></tr>
<tr><td>Semesterbeitrag (~${eu}250/sem = ${eu}42/mes)</td><td>${eu}42</td><td>180.000</td></tr>
<tr><td>Extras</td><td>${eu}100-200</td><td>430.000-860.000</td></tr>
<tr style="background:#e8fdf5"><td><strong>Total mensual</strong></td><td><strong>${eu}700-1.250</strong></td><td><strong>3.000.000-5.400.000</strong></td></tr>
</tbody></table>

<div class="info"><h4>💼 Trabajando 20h/semana cubro mis gastos?</h4><p>S${i}. Trabajando 20h/semana a EUR 12.82/hora = EUR 1.026/mes. Esto cubre el 80-100% de tus gastos de vida. Adem${a}s, en vacaciones (verano e invierno) puedes trabajar tiempo completo.</p></div>

<h2>Job Seeker Visa: Qu${e}date 18 Meses Despu${e}s de Graduarte</h2>
<p>Una ventaja que pocos conocen: al graduarte en Alemania puedes solicitar la <strong>Job Seeker Visa</strong> por hasta 18 meses para buscar trabajo. Si consigues empleo calificado, obtienes la visa de trabajo y eventualmente la residencia permanente.</p>

<div class="cta-box"><h3>${i}Quieres ir a Alemania?</h3><p>Te ayudamos a planear tu ruta: curso de idiomas, universidad y visa. Todo gratis para ti.</p><a href="https://wa.me/573014430722?text=Hola,%20quiero%20informaci${o}n%20para%20estudiar%20en%20Alemania" class="cta-button">Hablar con Samuel</a></div>

<p>📖 Lee tambi${e}n: <a href="/blog/estudiar-alemania-colombia-2026.html" style="color:#1B4B8C;font-weight:600">Gu${i}a completa: estudiar en Alemania desde Colombia</a></p>
</div></div>
<footer class="footer"><p>© 2026 Navia Global | <a href="/" style="color:rgba(255,255,255,.7)">Inicio</a> · <a href="/blog/" style="color:rgba(255,255,255,.7)">Blog</a> · <a href="/contacto.html" style="color:rgba(255,255,255,.7)">Contacto</a></p></footer>
<a href="https://wa.me/573014430722" class="wa-float" target="_blank" rel="noopener" aria-label="WhatsApp"><svg width="28" height="28" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg></a>
</body></html>
"@

Write-Host ""
Write-Host "Batch 1 completado: 3 articulos generados"
