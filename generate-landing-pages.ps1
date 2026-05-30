$enc = New-Object System.Text.UTF8Encoding($false)
$base = "C:\Users\User\.claude\navia-website"
$a=[char]225;$e=[char]233;$i=[char]237;$o=[char]243;$u=[char]250;$n=[char]241;$eu=[char]0x20AC

# ═══════════════════════════════════════════════════
# DATOS POR DESTINO
# ═══════════════════════════════════════════════════
$destinos = @(
  @{
    slug="australia"; nombre="Australia"; emoji="🇦🇺"; flag="au"
    titulo="Estudia en Australia desde Colombia 2026"
    keyword="estudiar en Australia desde Colombia"
    costo="AUD `$6,000"; moneda="AUD"; periodo="6 meses"
    salario="AUD `$24.95/hora"; horas="24h/semana"
    clima="Templado / C${a}lido"; visa="Subclase 500"
    postEstudio="2-4 a${n}os (Visa 485)"
    ciudades="Sydney, Melbourne, Brisbane, Gold Coast"
    color1="#1B4B8C"; color2="#296AB8"
    img="https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&w=1200&q=80"
    imgAlt="Sydney Opera House Australia"
    ventaja1="Trabajas 24h/semana mientras estudias"
    ventaja2="Salario m${i}nimo m${a}s alto del mundo: AUD `$24.95/h"
    ventaja3="Post-Study Work Visa de 2 a 4 a${n}os"
    ventaja4="7 universidades en el top 100 mundial"
    blogUrl="/blog/estudiar-australia-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Australia"
    visaUrl="/blog/visa-estudiante-australia-2026.html"
  },
  @{
    slug="irlanda"; nombre="Irlanda"; emoji="🇮🇪"; flag="ie"
    titulo="Estudia en Irlanda desde Colombia 2026"
    keyword="estudiar en Irlanda desde Colombia"
    costo="${eu}3,000"; moneda="EUR"; periodo="25 semanas"
    salario="${eu}13.50/hora"; horas="20h/semana"
    clima="Templado / Lluvioso"; visa="Visa de estudiante irlandesa"
    postEstudio="Stay Back para graduados"
    ciudades="Dubl${i}n, Cork, Galway"
    color1="#169B62"; color2="#1B4B8C"
    img="https://images.unsplash.com/photo-1549918864-48ac978761a4?auto=format&w=1200&q=80"
    imgAlt="Trinity College Dubl${i}n Irlanda"
    ventaja1="25 semanas = visa con permiso de trabajo incluido"
    ventaja2="Ingl${e}s con acento neutro, ideal para negocios"
    ventaja3="Puerta de entrada a Europa y zona Schengen"
    ventaja4="Destino m${a}s econ${o}mico de los pa${i}ses de habla inglesa"
    blogUrl="/blog/estudiar-irlanda-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Irlanda"
    visaUrl="/blog/visa-estudiante-irlanda-colombia-2026.html"
  },
  @{
    slug="canada"; nombre="Canad${a}"; emoji="🇨🇦"; flag="ca"
    titulo="Estudia en Canad${a} desde Colombia 2026"
    keyword="estudiar en Canad${a} desde Colombia"
    costo="CAD `$4,000"; moneda="CAD"; periodo="6 meses"
    salario="CAD ~`$17/hora"; horas="20h/semana"
    clima="Fr${i}o / Templado"; visa="Study Permit"
    postEstudio="PGWP hasta 3 a${n}os + PR pathway"
    ciudades="Toronto, Vancouver, Montreal"
    color1="#FF0000"; color2="#1B4B8C"
    img="https://images.unsplash.com/photo-1517935706615-2717063c2225?auto=format&w=1200&q=80"
    imgAlt="Toronto Canad${a} ciudad estudiantil"
    ventaja1="Pathway directo a residencia permanente (PR)"
    ventaja2="Trabaja 20h/semana durante el curso"
    ventaja3="Ingl${e}s y franc${e}s: doble ventaja profesional"
    ventaja4="PGWP hasta 3 a${n}os post-graduaci${o}n"
    blogUrl="/blog/estudiar-canada-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Canad${a}"
    visaUrl="/blog/visa-estudiante-canada-2026.html"
  },
  @{
    slug="malta"; nombre="Malta"; emoji="🇲🇹"; flag="mt"
    titulo="Estudia en Malta desde Colombia 2026"
    keyword="estudiar en Malta desde Colombia"
    costo="${eu}3,200"; moneda="EUR"; periodo="6 meses"
    salario="${eu}5.42/hora"; horas="20h/semana"
    clima="Mediterr${a}neo"; visa="Visa estudiante Malta"
    postEstudio="Limitado"
    ciudades="Valletta, Sliema, St. Julian's"
    color1="#CF142B"; color2="#1B4B8C"
    img="https://images.unsplash.com/photo-1514565131-fce0801e6785?auto=format&w=1200&q=80"
    imgAlt="Valletta Malta ciudad mediterr${a}nea"
    ventaja1="La opci${o}n m${a}s econ${o}mica de Europa en euros"
    ventaja2="Clima mediterr${a}neo: sol 300 d${i}as al a${n}o"
    ventaja3="Ingl${e}s oficial: segundo idioma del pa${i}s"
    ventaja4="Vida nocturna y playas incre${i}bles"
    blogUrl="/blog/estudiar-malta-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Malta"
    visaUrl="/blog/visa-estudiante-malta-colombia-2026.html"
  },
  @{
    slug="dubai"; nombre="Dubai"; emoji="🇦🇪"; flag="ae"
    titulo="Estudia en Dubai desde Colombia 2026"
    keyword="estudiar en Dubai desde Colombia"
    costo="USD `$4,000"; moneda="USD"; periodo="6 meses"
    salario="Variable"; horas="Variable seg${u}n escuela"
    clima="Desiert${o} / Muy c${a}lido"; visa="Student Visa UAE"
    postEstudio="Limitado"
    ciudades="Dub${a}i, Abu Dhabi"
    color1="#00732F"; color2="#1B4B8C"
    img="https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&w=1200&q=80"
    imgAlt="Dubai skyline Burj Khalifa"
    ventaja1="Destino de lujo a precio competitivo"
    ventaja2="Hub de negocios internacional"
    ventaja3="Sin impuestos: dinero que ahorras es tuyo"
    ventaja4="Networking con profesionales de todo el mundo"
    blogUrl="/blog/estudiar-dubai-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Dubai"
    visaUrl="/blog/visa-estudiante-dubai-colombia-2026.html"
  },
  @{
    slug="nueva-zelanda"; nombre="Nueva Zelanda"; emoji="🇳🇿"; flag="nz"
    titulo="Estudia en Nueva Zelanda desde Colombia 2026"
    keyword="estudiar en Nueva Zelanda desde Colombia"
    costo="NZD `$6,000"; moneda="NZD"; periodo="6 meses"
    salario="NZD `$23.15/hora"; horas="25h/semana"
    clima="Templado"; visa="Student Visa NZ"
    postEstudio="Post Study Work 3 a${n}os"
    ciudades="Auckland, Wellington, Christchurch"
    color1="#00247D"; color2="#1B4B8C"
    img="https://images.unsplash.com/photo-1507699622108-4be3abd695ad?auto=format&w=1200&q=80"
    imgAlt="Auckland Nueva Zelanda naturaleza"
    ventaja1="Puedes trabajar 25h/semana mientras estudias"
    ventaja2="Post-Study Work Visa de 3 a${n}os"
    ventaja3="Naturaleza incre${i}ble: fiordo, glaciares y playas"
    ventaja4="Comunidad latina peque${n}a pero muy unida"
    blogUrl="/blog/estudiar-nueva-zelanda-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Nueva Zelanda"
    visaUrl="/blog/visa-estudiante-nueva-zelanda-colombia-2026.html"
  },
  @{
    slug="reino-unido"; nombre="Reino Unido"; emoji="🇬🇧"; flag="gb"
    titulo="Estudia en Reino Unido desde Colombia 2026"
    keyword="estudiar en Reino Unido desde Colombia"
    costo="GBP 4,000"; moneda="GBP"; periodo="6 meses"
    salario="GBP ${eu}11.44/hora"; horas="20h/semana"
    clima="Templado / Lluvioso"; visa="Student Visa UK"
    postEstudio="Graduate Route 2-3 a${n}os"
    ciudades="Londres, Manchester, Edimburgo"
    color1="#012169"; color2="#1B4B8C"
    img="https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?auto=format&w=1200&q=80"
    imgAlt="Londres Big Ben Reino Unido"
    ventaja1="El ingl${e}s brit${a}nico, el m${a}s valorado globalmente"
    ventaja2="Graduate Route: 2 a${n}os de trabajo post-graduaci${o}n"
    ventaja3="Londres: capital financiera y cultural del mundo"
    ventaja4="Acceso a universidades del G5: Oxford, Cambridge, Imperial"
    blogUrl="/blog/estudiar-reino-unido-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Reino Unido"
    visaUrl="/blog/visa-estudiante-reino-unido-colombia-2026.html"
  },
  @{
    slug="estados-unidos"; nombre="Estados Unidos"; emoji="🇺🇸"; flag="us"
    titulo="Estudia en Estados Unidos desde Colombia 2026"
    keyword="estudiar en Estados Unidos desde Colombia"
    costo="USD `$5,000"; moneda="USD"; periodo="6 meses"
    salario="USD `$7.25+/hora"; horas="Limitado (F-1)"
    clima="Var${i}a por ciudad"; visa="Visa F-1"
    postEstudio="OPT hasta 3 a${n}os (STEM)"
    ciudades="Nueva York, Miami, Boston, Los ${a}ngeles"
    color1="#B22234"; color2="#1B4B8C"
    img="https://images.unsplash.com/photo-1499092346589-b9b6be3e94b2?auto=format&w=1200&q=80"
    imgAlt="Nueva York Estados Unidos ciudad estudiantil"
    ventaja1="El ingl${e}s americano: el m${a}s usado en negocios globales"
    ventaja2="OPT hasta 3 a${n}os para carreras STEM"
    ventaja3="Acceso a las mejores universidades del mundo"
    ventaja4="Miami: la ciudad m${a}s bilinge de Norteam${e}rica"
    blogUrl="/blog/estudiar-estados-unidos-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Estados Unidos"
    visaUrl="/blog/visa-estudiante-estados-unidos-colombia-2026.html"
  },
  @{
    slug="francia"; nombre="Francia"; emoji="🇫🇷"; flag="fr"
    titulo="Estudia franc${e}s en Francia desde Colombia 2026"
    keyword="estudiar en Francia desde Colombia"
    costo="${eu}5,000"; moneda="EUR"; periodo="6 meses"
    salario="${eu}11.88/hora (SMIC)"; horas="20h/semana"
    clima="Templado / Continental"; visa="Visa estudiante Francia"
    postEstudio="Limitado"
    ciudades="Par${i}s, Lyon, Niza, Burdeos"
    color1="#002395"; color2="#ED2939"
    img="https://images.unsplash.com/photo-1431274172761-fca41d930114?auto=format&w=1200&q=80"
    imgAlt="Par${i}s Torre Eiffel Francia"
    ventaja1="Franc${e}s: el segundo idioma m${a}s valioso del mundo"
    ventaja2="Cultura y gastronomia que te cambian la vida"
    ventaja3="Acceso a toda Europa con zona Schengen"
    ventaja4="Empleo en multinacionales francesas en LATAM"
    blogUrl="/blog/estudiar-francia-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Francia"
    visaUrl="/blog/visa-schengen-colombianos-2026.html"
  },
  @{
    slug="alemania"; nombre="Alemania"; emoji="🇩🇪"; flag="de"
    titulo="Estudia alem${a}n en Alemania desde Colombia 2026"
    keyword="estudiar en Alemania desde Colombia"
    costo="${eu}4,000"; moneda="EUR"; periodo="6 meses"
    salario="${eu}12.82/hora (Mindestlohn)"; horas="20h/semana"
    clima="Continental / Fr${i}o"; visa="Visa nacional alemana"
    postEstudio="Job Seeker Visa hasta 18 meses"
    ciudades="Berl${i}n, M${u}nich, Hamburgo"
    color1="#000000"; color2="#DD0000"
    img="https://images.unsplash.com/photo-1467269204594-9661b134dd2b?auto=format&w=1200&q=80"
    imgAlt="Berl${i}n Alemania puerta de Brandeburgo"
    ventaja1="Job Seeker Visa: 18 meses para conseguir trabajo tras graduarte"
    ventaja2="Universidades p${u}blicas sin matr${i}cula para extranjeros"
    ventaja3="Econom${i}a #1 de Europa: alta demanda de profesionales"
    ventaja4="Alem${a}n + ingl${e}s = perfil muy cotizado globalmente"
    blogUrl="/blog/estudiar-alemania-colombia-2026.html"
    blogTxt="Gu${i}a completa: estudiar en Alemania"
    visaUrl="/blog/visa-estudiante-alemania-colombia-2026.html"
  }
)

# ═══════════════════════════════════════════════════
# TEMPLATE HTML LANDING PAGE
# ═══════════════════════════════════════════════════
function Make-Landing($d) {
  $n = $d.nombre; $sl = $d.slug
  return @"
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<link rel="canonical" href="https://naviaglobal.co/$sl/">
<link rel="author" href="/sobre-samuel-sanchez.html">
<title>Estudiar en $n desde Colombia 2026 | Agencia Navia Global</title>
<meta name="description" content="Agencia especializada en $($d.keyword). Asesor${i}a gratuita, tr${a}mites de visa, escuelas seleccionadas. +500 colombianos exitosos. Consulta sin costo.">
<meta property="og:title" content="Estudiar en $n desde Colombia 2026 | Navia Global">
<meta property="og:description" content="Asesor${i}a gratuita para colombianos que quieren $($d.keyword). Proceso completo: escuela, visa, alojamiento.">
<meta property="og:image" content="$($d.img)">
<meta property="og:type" content="website">
<meta name="twitter:card" content="summary_large_image">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&family=Poppins:wght@700;800&display=swap" rel="stylesheet">
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"Service","name":"Asesor${i}a para estudiar en $n desde Colombia","provider":{"@type":"EducationalOrganization","name":"Navia Global","url":"https://naviaglobal.co","telephone":"+573014430722","email":"info@naviaglobal.co","address":{"@type":"PostalAddress","addressCountry":"CO","addressRegion":"Bogot${a}"}},"serviceType":"Asesor${i}a en estudios en el exterior","areaServed":"CO","description":"Asesor${i}a gratuita para colombianos que desean estudiar en $n. Incluye selecci${o}n de escuela, tr${a}mites de visa y apoyo en alojamiento.","offers":{"@type":"Offer","price":"0","priceCurrency":"COP","description":"Asesor${i}a completamente gratuita para el estudiante"}}
</script>
<script type="application/ld+json">
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"name":"Inicio","item":"https://naviaglobal.co"},{"@type":"ListItem","position":2,"name":"Destinos","item":"https://naviaglobal.co/#destinos"},{"@type":"ListItem","position":3,"name":"Estudiar en $n","item":"https://naviaglobal.co/$sl/"}]}
</script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;color:#2C3E50;background:#fff;line-height:1.6}
.navbar{background:#0A2463;padding:12px 0;position:sticky;top:0;z-index:100;box-shadow:0 2px 10px rgba(0,0,0,.2)}
.nav-inner{max-width:1100px;margin:0 auto;padding:0 24px;display:flex;justify-content:space-between;align-items:center}
.nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
.nav-logo img{height:36px;width:auto}
.nav-logo span{font-family:'Poppins',sans-serif;font-weight:800;font-size:1.05rem;color:#fff}
.nav-cta{background:#1ABC9C;color:#fff;padding:10px 22px;border-radius:25px;text-decoration:none;font-weight:700;font-size:.9rem}
.hero{background:linear-gradient(135deg,$($d.color1) 0%,$($d.color2) 100%);color:#fff;padding:72px 24px 56px;text-align:center}
.hero-badge{display:inline-block;background:rgba(255,255,255,.15);border:1px solid rgba(255,255,255,.3);border-radius:25px;padding:6px 18px;font-size:.82rem;font-weight:700;letter-spacing:.05em;margin-bottom:20px}
.hero h1{font-family:'Poppins',sans-serif;font-size:2.6rem;font-weight:800;line-height:1.2;margin-bottom:16px}
.hero p{font-size:1.1rem;opacity:.92;max-width:600px;margin:0 auto 32px}
.hero-cta{display:inline-flex;align-items:center;gap:10px;background:#1ABC9C;color:#fff;padding:16px 36px;border-radius:50px;text-decoration:none;font-weight:800;font-size:1.05rem;box-shadow:0 6px 24px rgba(0,0,0,.2);transition:transform .15s}
.hero-cta:hover{transform:translateY(-2px)}
.hero-img{width:100%;max-width:900px;height:320px;object-fit:cover;border-radius:16px;margin:40px auto 0;display:block;box-shadow:0 16px 48px rgba(0,0,0,.25)}
.stats-bar{background:#fff;border-bottom:2px solid #EEF2FF;padding:20px 24px}
.stats-inner{max-width:1100px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(160px,1fr));gap:16px}
.stat{text-align:center}
.stat-val{font-family:'Poppins',sans-serif;font-size:1.3rem;font-weight:800;color:#0A2463}
.stat-lbl{font-size:.78rem;color:#6B7280;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin-top:2px}
.section{padding:64px 24px}
.section-alt{background:#F8FAFF}
.container{max-width:1100px;margin:0 auto}
.section-tag{display:inline-block;background:#EEF4FF;color:#1B4B8C;padding:4px 14px;border-radius:20px;font-size:.78rem;font-weight:700;text-transform:uppercase;letter-spacing:.06em;margin-bottom:12px}
.section h2{font-family:'Poppins',sans-serif;font-size:2rem;font-weight:800;color:#0A2463;margin-bottom:12px}
.section-sub{color:#6B7280;font-size:1rem;margin-bottom:40px;max-width:560px}
.ventajas{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:20px;margin-top:8px}
.ventaja{background:#fff;border:1px solid #E8EFFF;border-radius:14px;padding:22px 20px;display:flex;gap:14px;align-items:flex-start;box-shadow:0 2px 8px rgba(27,75,140,.06)}
.ventaja-icon{background:#EEF4FF;color:#1B4B8C;width:40px;height:40px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1.1rem;flex-shrink:0}
.ventaja h3{font-size:.95rem;font-weight:700;color:#0A2463;margin-bottom:4px}
.ventaja p{font-size:.85rem;color:#6B7280;line-height:1.5}
.proceso{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:24px;margin-top:8px}
.paso{background:#fff;border-radius:14px;padding:28px 22px;text-align:center;border:1px solid #E8EFFF;box-shadow:0 2px 8px rgba(27,75,140,.06)}
.paso-num{background:linear-gradient(135deg,#1B4B8C,#1ABC9C);color:#fff;width:44px;height:44px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:800;font-size:1.1rem;margin:0 auto 16px}
.paso h3{font-size:1rem;font-weight:700;color:#0A2463;margin-bottom:8px}
.paso p{font-size:.88rem;color:#6B7280;line-height:1.5}
.info-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:16px;margin-top:8px}
.info-item{background:#fff;border-radius:12px;padding:18px;border-left:4px solid #1B4B8C}
.info-item .label{font-size:.75rem;font-weight:700;color:#6B7280;text-transform:uppercase;letter-spacing:.05em;margin-bottom:6px}
.info-item .value{font-size:1rem;font-weight:700;color:#0A2463}
.cta-section{background:linear-gradient(135deg,#0A2463 0%,#1B4B8C 100%);color:#fff;padding:72px 24px;text-align:center}
.cta-section h2{font-family:'Poppins',sans-serif;font-size:2.2rem;font-weight:800;margin-bottom:12px}
.cta-section p{font-size:1.1rem;opacity:.9;margin-bottom:8px;max-width:550px;margin-left:auto;margin-right:auto}
.cta-section .free-badge{display:inline-block;background:#1ABC9C;color:#fff;padding:4px 14px;border-radius:20px;font-size:.82rem;font-weight:700;margin-bottom:28px}
.cta-btns{display:flex;gap:14px;justify-content:center;flex-wrap:wrap;margin-top:8px}
.btn-wa{background:#25D366;color:#fff;padding:16px 34px;border-radius:50px;text-decoration:none;font-weight:800;font-size:1rem;display:inline-flex;align-items:center;gap:8px;box-shadow:0 6px 24px rgba(37,211,102,.3);transition:transform .15s}
.btn-wa:hover{transform:translateY(-2px)}
.btn-outline{background:transparent;color:#fff;border:2px solid rgba(255,255,255,.5);padding:16px 34px;border-radius:50px;text-decoration:none;font-weight:700;font-size:1rem;transition:border-color .15s}
.btn-outline:hover{border-color:#fff}
.blog-link{background:#F8FAFF;border:1px solid #D6E4FF;border-radius:14px;padding:22px 26px;display:flex;justify-content:space-between;align-items:center;text-decoration:none;margin-top:32px;gap:16px}
.blog-link-text h3{font-size:1rem;font-weight:700;color:#0A2463;margin-bottom:4px}
.blog-link-text p{font-size:.88rem;color:#6B7280}
.blog-link-arrow{background:#1B4B8C;color:#fff;width:40px;height:40px;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;font-size:1.1rem}
.footer{background:#0A2463;color:rgba(255,255,255,.75);padding:40px 24px;text-align:center}
.footer a{color:rgba(255,255,255,.75);text-decoration:none}
.footer-links{display:flex;gap:24px;justify-content:center;margin-top:12px;font-size:.88rem}
.wa-float{position:fixed;bottom:28px;right:28px;width:56px;height:56px;background:#25D366;border-radius:50%;display:flex;align-items:center;justify-content:center;text-decoration:none;box-shadow:0 4px 16px rgba(37,211,102,.4);z-index:999}
@media(max-width:768px){
  .hero h1{font-size:1.9rem}
  .hero-img{height:200px}
  .stats-inner{grid-template-columns:repeat(2,1fr)}
  .cta-btns{flex-direction:column;align-items:center}
  .blog-link{flex-direction:column}
}
</style>
</head>
<body>

<nav class="navbar">
<div class="nav-inner">
  <a href="/" class="nav-logo">
    <img src="/logo.webp" alt="Navia Global" width="36" height="36">
    <span>Navia Global</span>
  </a>
  <a href="https://wa.me/573014430722?text=Hola,%20quiero%20informaci${o}n%20para%20estudiar%20en%20$n" class="nav-cta">Asesor${i}a Gratuita</a>
</div>
</nav>

<section class="hero">
<div class="hero-badge">$($d.emoji) $n &bull; 2026</div>
<h1>$($d.titulo)</h1>
<p>Asesor${i}a gratuita, tr${a}mites completos y acompa${n}amiento hasta que llegues a $n. +500 colombianos exitosos.</p>
<a href="https://wa.me/573014430722?text=Hola,%20quiero%20asesor${i}a%20para%20estudiar%20en%20$n" class="hero-cta">
  <svg width="20" height="20" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg>
  Quiero informaci${o}n gratis
</a>
<img src="$($d.img)" alt="$($d.imgAlt)" class="hero-img" width="1200" height="320" fetchpriority="high">
</section>

<div class="stats-bar">
<div class="stats-inner">
  <div class="stat"><div class="stat-val">$($d.costo)</div><div class="stat-lbl">Curso $($d.periodo)</div></div>
  <div class="stat"><div class="stat-val">$($d.salario)</div><div class="stat-lbl">Salario</div></div>
  <div class="stat"><div class="stat-val">$($d.horas)</div><div class="stat-lbl">Trabajo permitido</div></div>
  <div class="stat"><div class="stat-val">$($d.postEstudio)</div><div class="stat-lbl">Post-estudio</div></div>
  <div class="stat"><div class="stat-val">100% gratis</div><div class="stat-lbl">Nuestra asesor${i}a</div></div>
</div>
</div>

<section class="section">
<div class="container">
  <span class="section-tag">Por qu${e} $n</span>
  <h2>Las 4 razones que eligen nuestros estudiantes</h2>
  <p class="section-sub">Basado en la experiencia de +500 colombianos que ya estudiaron en $n con Navia Global.</p>
  <div class="ventajas">
    <div class="ventaja">
      <div class="ventaja-icon">1</div>
      <div><h3>$($d.ventaja1)</h3></div>
    </div>
    <div class="ventaja">
      <div class="ventaja-icon">2</div>
      <div><h3>$($d.ventaja2)</h3></div>
    </div>
    <div class="ventaja">
      <div class="ventaja-icon">3</div>
      <div><h3>$($d.ventaja3)</h3></div>
    </div>
    <div class="ventaja">
      <div class="ventaja-icon">4</div>
      <div><h3>$($d.ventaja4)</h3></div>
    </div>
  </div>
</div>
</section>

<section class="section section-alt">
<div class="container">
  <span class="section-tag">Datos Clave</span>
  <h2>$n en n${u}meros reales</h2>
  <p class="section-sub">Costos y condiciones verificados. Actualizados mayo 2026.</p>
  <div class="info-grid">
    <div class="info-item"><div class="label">Costo del curso</div><div class="value">$($d.costo) / $($d.periodo)</div></div>
    <div class="info-item"><div class="label">Horas de trabajo</div><div class="value">$($d.horas)</div></div>
    <div class="info-item"><div class="label">Salario</div><div class="value">$($d.salario)</div></div>
    <div class="info-item"><div class="label">Tipo de visa</div><div class="value">$($d.visa)</div></div>
    <div class="info-item"><div class="label">Ciudades principales</div><div class="value">$($d.ciudades)</div></div>
    <div class="info-item"><div class="label">Post-estudio</div><div class="value">$($d.postEstudio)</div></div>
  </div>
  <a href="$($d.blogUrl)" class="blog-link">
    <div class="blog-link-text">
      <h3>$($d.blogTxt)</h3>
      <p>Gu${i}a completa con requisitos, proceso de visa, costos desglosados y consejos reales.</p>
    </div>
    <div class="blog-link-arrow">&#8594;</div>
  </a>
</div>
</section>

<section class="section">
<div class="container">
  <span class="section-tag">C${o}mo funciona</span>
  <h2>3 pasos para llegar a $n</h2>
  <p class="section-sub">Navia Global te acompa${n}a en cada paso. Sin costos ocultos, sin complicaciones.</p>
  <div class="proceso">
    <div class="paso">
      <div class="paso-num">1</div>
      <h3>Asesor${i}a gratuita</h3>
      <p>Analizamos tu perfil, objetivos y presupuesto. Te recomendamos la mejor escuela y ciudad para ti en $n.</p>
    </div>
    <div class="paso">
      <div class="paso-num">2</div>
      <h3>Tr${a}mites y visa</h3>
      <p>Gestionamos tu admisi${o}n, preparamos los documentos y te gu${i}amos en la solicitud de visa paso a paso.</p>
    </div>
    <div class="paso">
      <div class="paso-num">3</div>
      <h3>Viaja y empieza</h3>
      <p>Llega con todo listo: alojamiento confirmado, escuela pagada y grupo de WhatsApp con colombianos en $n.</p>
    </div>
  </div>
</div>
</section>

<section class="cta-section" id="contacto">
<div class="container">
  <h2>Lista para asesorarte sin costo</h2>
  <p>Resolvemos todas tus dudas sobre estudiar en $n, costos exactos, visas, escuelas y m${a}s.</p>
  <div class="free-badge">Asesor${i}a 100% gratuita para el estudiante</div>
  <div class="cta-btns">
    <a href="https://wa.me/573014430722?text=Hola,%20quiero%20asesor${i}a%20para%20estudiar%20en%20$n" class="btn-wa">
      <svg width="20" height="20" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg>
      WhatsApp: 301 4430722
    </a>
    <a href="mailto:info@naviaglobal.co" class="btn-outline">info@naviaglobal.co</a>
  </div>
</div>
</section>

<footer class="footer">
<p>© 2026 Navia Global — Agencia colombiana de estudios en el exterior</p>
<div class="footer-links">
  <a href="/">Inicio</a>
  <a href="/blog/">Blog</a>
  <a href="/contacto.html">Contacto</a>
  <a href="/sobre-samuel-sanchez.html">Sobre Samuel</a>
  <a href="/politica-de-privacidad.html">Privacidad</a>
</div>
</footer>

<a href="https://wa.me/573014430722?text=Hola,%20quiero%20informaci${o}n%20para%20estudiar%20en%20$n" class="wa-float" target="_blank" rel="noopener" aria-label="WhatsApp">
<svg width="30" height="30" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg>
</a>

</body>
</html>
"@
}

# ═══════════════════════════════════════════════════
# GENERAR LAS 10 LANDING PAGES
# ═══════════════════════════════════════════════════
$creados = 0
foreach ($d in $destinos) {
    $dir = Join-Path $base $d.slug
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $file = Join-Path $dir "index.html"
    $html = Make-Landing $d
    [System.IO.File]::WriteAllText($file, $html, $enc)
    $creados++
    Write-Host "[OK] /$($d.slug)/index.html"
}

# ═══════════════════════════════════════════════════
# GENERAR /contacto.html
# ═══════════════════════════════════════════════════
$contacto = @"
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<link rel="canonical" href="https://naviaglobal.co/contacto.html">
<link rel="author" href="/sobre-samuel-sanchez.html">
<title>Contacto | Navia Global — Agencia Estudios en el Exterior Colombia</title>
<meta name="description" content="Cont${a}ctanos para asesor${i}a gratuita sobre estudiar en el exterior desde Colombia. WhatsApp: 301 4430722. Respondemos en menos de 2 horas.">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&family=Poppins:wght@700;800&display=swap" rel="stylesheet">
<script type="application/ld+json">
{"@context":"https://schema.org","@type":["LocalBusiness","EducationalOrganization"],"name":"Navia Global","url":"https://naviaglobal.co","telephone":"+573014430722","email":"info@naviaglobal.co","description":"Agencia colombiana especializada en asesor${i}a para estudios en el exterior. Atendemos estudiantes de todo Colombia.","address":{"@type":"PostalAddress","addressCountry":"CO","addressRegion":"Bogot${a}","addressLocality":"Bogot${a}"},"openingHoursSpecification":{"@type":"OpeningHoursSpecification","dayOfWeek":["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"opens":"08:00","closes":"20:00"},"sameAs":["https://naviaglobal.co"],"founder":{"@type":"Person","name":"Samuel S${a}nchez","url":"https://naviaglobal.co/sobre-samuel-sanchez.html"}}
</script>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',sans-serif;color:#2C3E50;background:#fff;line-height:1.6}
.navbar{background:#0A2463;padding:12px 0}
.nav-inner{max-width:1100px;margin:0 auto;padding:0 24px;display:flex;justify-content:space-between;align-items:center}
.nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none}
.nav-logo img{height:36px;width:auto}
.nav-logo span{font-family:'Poppins',sans-serif;font-weight:800;font-size:1.05rem;color:#fff}
.nav-cta{background:#1ABC9C;color:#fff;padding:10px 22px;border-radius:25px;text-decoration:none;font-weight:700;font-size:.9rem}
.hero{background:linear-gradient(135deg,#0A2463,#1B4B8C);color:#fff;padding:64px 24px;text-align:center}
.hero h1{font-family:'Poppins',sans-serif;font-size:2.4rem;font-weight:800;margin-bottom:12px}
.hero p{font-size:1.05rem;opacity:.9;max-width:520px;margin:0 auto}
.content{max-width:1000px;margin:0 auto;padding:64px 24px}
.contact-grid{display:grid;grid-template-columns:1fr 1fr;gap:40px}
.card{background:#F8FAFF;border:1px solid #E0ECFF;border-radius:16px;padding:32px}
.card h2{font-family:'Poppins',sans-serif;font-size:1.4rem;color:#0A2463;margin-bottom:20px}
.contact-item{display:flex;align-items:flex-start;gap:14px;margin-bottom:20px}
.ci-icon{background:#EEF4FF;color:#1B4B8C;width:44px;height:44px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;flex-shrink:0}
.ci-label{font-size:.78rem;font-weight:700;color:#6B7280;text-transform:uppercase;letter-spacing:.05em;margin-bottom:4px}
.ci-value{font-size:1rem;font-weight:700;color:#0A2463}
.ci-value a{color:#0A2463;text-decoration:none}
.ci-note{font-size:.82rem;color:#6B7280;margin-top:2px}
.wa-btn{display:flex;align-items:center;justify-content:center;gap:10px;background:#25D366;color:#fff;padding:18px 32px;border-radius:50px;text-decoration:none;font-weight:800;font-size:1.05rem;box-shadow:0 6px 24px rgba(37,211,102,.3);margin-top:24px;transition:transform .15s}
.wa-btn:hover{transform:translateY(-2px)}
.destinos-link{margin-top:40px}
.destinos-link h2{font-family:'Poppins',sans-serif;font-size:1.4rem;color:#0A2463;margin-bottom:16px}
.dest-chips{display:flex;flex-wrap:wrap;gap:10px}
.dest-chip{background:#EEF4FF;color:#1B4B8C;padding:8px 16px;border-radius:25px;text-decoration:none;font-size:.88rem;font-weight:600;border:1px solid #D0E3FF;transition:background .15s}
.dest-chip:hover{background:#D0E3FF}
.footer{background:#0A2463;color:rgba(255,255,255,.75);padding:32px 24px;text-align:center;font-size:.9rem}
.footer-links{display:flex;gap:24px;justify-content:center;margin-top:10px}
.footer a{color:rgba(255,255,255,.75);text-decoration:none}
.wa-float{position:fixed;bottom:28px;right:28px;width:56px;height:56px;background:#25D366;border-radius:50%;display:flex;align-items:center;justify-content:center;text-decoration:none;box-shadow:0 4px 16px rgba(37,211,102,.4);z-index:999}
@media(max-width:768px){.contact-grid{grid-template-columns:1fr}.hero h1{font-size:1.8rem}}
</style>
</head>
<body>
<nav class="navbar">
<div class="nav-inner">
  <a href="/" class="nav-logo">
    <img src="/logo.webp" alt="Navia Global" width="36" height="36">
    <span>Navia Global</span>
  </a>
  <a href="https://wa.me/573014430722" class="nav-cta">WhatsApp</a>
</div>
</nav>

<section class="hero">
<h1>Cont${a}ctanos</h1>
<p>Asesor${i}a gratuita para estudiar en el exterior desde Colombia. Respondemos en menos de 2 horas.</p>
</section>

<div class="content">
<div class="contact-grid">

  <div class="card">
    <h2>Inf${o}rmaci${o}n de contacto</h2>
    <div class="contact-item">
      <div class="ci-icon">📱</div>
      <div>
        <div class="ci-label">WhatsApp</div>
        <div class="ci-value"><a href="https://wa.me/573014430722">+57 301 4430722</a></div>
        <div class="ci-note">Lun–S${a}b 8am–8pm (hora Colombia)</div>
      </div>
    </div>
    <div class="contact-item">
      <div class="ci-icon">✉️</div>
      <div>
        <div class="ci-label">Email</div>
        <div class="ci-value"><a href="mailto:info@naviaglobal.co">info@naviaglobal.co</a></div>
        <div class="ci-note">Respuesta en menos de 24 horas</div>
      </div>
    </div>
    <div class="contact-item">
      <div class="ci-icon">🌐</div>
      <div>
        <div class="ci-label">Sitio web</div>
        <div class="ci-value"><a href="https://naviaglobal.co">naviaglobal.co</a></div>
        <div class="ci-note">Colombia — atendemos todo el pa${i}s</div>
      </div>
    </div>
    <div class="contact-item">
      <div class="ci-icon">⭐</div>
      <div>
        <div class="ci-label">Google Business</div>
        <div class="ci-value"><a href="https://g.page/r/CXwJVfso_PIXEAE/review" target="_blank" rel="noopener">Ver rese${n}as en Google</a></div>
        <div class="ci-note">4.9/5 — +15 rese${n}as verificadas</div>
      </div>
    </div>
    <a href="https://wa.me/573014430722?text=Hola%20Navia%20Global%2C%20quiero%20informaci${o}n%20sobre%20estudiar%20en%20el%20exterior" class="wa-btn">
      <svg width="22" height="22" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg>
      Escribir por WhatsApp ahora
    </a>
  </div>

  <div class="card">
    <h2>${i}Con qu${e} podemos ayudarte?</h2>
    <div class="contact-item">
      <div class="ci-icon">✈️</div>
      <div><div class="ci-label">Elecci${o}n de destino</div><div class="ci-value">Te ayudamos a elegir el pa${i}s ideal seg${u}n tu perfil, presupuesto y objetivos.</div></div>
    </div>
    <div class="contact-item">
      <div class="ci-icon">🏫</div>
      <div><div class="ci-label">Selecci${o}n de escuela</div><div class="ci-value">Comparamos escuelas y conseguimos las mejores condiciones para ti.</div></div>
    </div>
    <div class="contact-item">
      <div class="ci-icon">🛂</div>
      <div><div class="ci-label">Tr${a}mites de visa</div><div class="ci-value">Te gu${i}amos en cada paso del proceso de visa. 95% de tasa de aprobaci${o}n.</div></div>
    </div>
    <div class="contact-item">
      <div class="ci-icon">🏠</div>
      <div><div class="ci-label">Alojamiento y llegada</div><div class="ci-value">Coordinamos tu homestay o residencia para que llegues con todo confirmado.</div></div>
    </div>
  </div>
</div>

<div class="destinos-link">
  <h2>Destinos que manejamos</h2>
  <div class="dest-chips">
    <a href="/australia/" class="dest-chip">🇦🇺 Australia</a>
    <a href="/irlanda/" class="dest-chip">🇮🇪 Irlanda</a>
    <a href="/canada/" class="dest-chip">🇨🇦 Canad${a}</a>
    <a href="/malta/" class="dest-chip">🇲🇹 Malta</a>
    <a href="/dubai/" class="dest-chip">🇦🇪 Dubai</a>
    <a href="/nueva-zelanda/" class="dest-chip">🇳🇿 Nueva Zelanda</a>
    <a href="/reino-unido/" class="dest-chip">🇬🇧 Reino Unido</a>
    <a href="/estados-unidos/" class="dest-chip">🇺🇸 Estados Unidos</a>
    <a href="/francia/" class="dest-chip">🇫🇷 Francia</a>
    <a href="/alemania/" class="dest-chip">🇩🇪 Alemania</a>
  </div>
</div>
</div>

<footer class="footer">
<p>© 2026 Navia Global — Colombia</p>
<div class="footer-links">
  <a href="/">Inicio</a>
  <a href="/blog/">Blog</a>
  <a href="/sobre-samuel-sanchez.html">Sobre Samuel</a>
  <a href="/politica-de-privacidad.html">Privacidad</a>
  <a href="/terminos-y-condiciones.html">T${e}rminos</a>
</div>
</footer>

<a href="https://wa.me/573014430722" class="wa-float" target="_blank" rel="noopener" aria-label="WhatsApp">
<svg width="30" height="30" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.938 15.938 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm0 29.38c-2.42 0-4.78-.656-6.853-1.897l-.492-.291-5.122 1.299 1.324-5.016-.32-.508A13.316 13.316 0 012.62 16c0-7.364 5.997-13.36 13.38-13.36 7.382 0 13.38 5.996 13.38 13.36S23.382 29.38 16 29.38z"/><path d="M23.338 19.73c-.404-.202-2.388-1.178-2.757-1.312-.37-.135-.638-.202-.908.202-.27.403-1.044 1.312-1.28 1.582-.235.27-.47.304-.874.101-.403-.202-1.703-.628-3.244-2.003-1.2-1.07-2.01-2.391-2.246-2.794-.235-.404-.025-.622.177-.823.182-.181.404-.471.606-.707.202-.236.27-.404.404-.673.135-.27.068-.505-.034-.707-.101-.202-.908-2.186-1.244-2.993-.328-.787-.66-.68-.908-.692-.235-.011-.505-.014-.774-.014s-.707.101-1.077.505c-.37.403-1.413 1.38-1.413 3.367 0 1.986 1.447 3.907 1.65 4.176.201.27 2.843 4.342 6.888 6.088.962.415 1.713.663 2.298.849.966.307 1.845.264 2.54.16.775-.115 2.388-.977 2.724-1.92.337-.944.337-1.751.236-1.92-.101-.17-.37-.27-.774-.473z"/></svg>
</a>
</body>
</html>
"@

$contactoPath = Join-Path $base "contacto.html"
[System.IO.File]::WriteAllText($contactoPath, $contacto, $enc)
Write-Host "[OK] /contacto.html"

# ═══════════════════════════════════════════════════
# ACTUALIZAR SITEMAP con las 11 nuevas paginas
# ═══════════════════════════════════════════════════
$sitemapPath = Join-Path $base "sitemap.xml"
$sitemap = [System.IO.File]::ReadAllText($sitemapPath, [System.Text.Encoding]::UTF8)

$newUrls = ""
foreach ($d in $destinos) {
    $newUrls += "
  <url>
    <loc>https://naviaglobal.co/$($d.slug)/</loc>
    <lastmod>2026-05-12</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.95</priority>
  </url>"
}
$newUrls += "
  <url>
    <loc>https://naviaglobal.co/contacto.html</loc>
    <lastmod>2026-05-12</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>"

# Insertar antes del cierre del sitemap
$sitemap = $sitemap.Replace('</urlset>', $newUrls + "`n`n</urlset>")
[System.IO.File]::WriteAllText($sitemapPath, $sitemap, $enc)

Write-Host "[OK] Sitemap actualizado con $($destinos.Count + 1) nuevas URLs"
Write-Host ""
Write-Host "Total creado: $($creados + 1) paginas nuevas (10 destinos + contacto)"
