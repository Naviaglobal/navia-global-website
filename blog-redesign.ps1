$f = 'C:\Users\User\.claude\navia-website\blog\index.html'
$c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)

# ============================================================
# 1. CSS
# ============================================================
$newCSS = '.blog-layout{display:flex;align-items:flex-start;background:#f7f9fc}.blog-sidebar{width:248px;flex-shrink:0;position:sticky;top:58px;height:calc(100vh - 58px);overflow-y:auto;background:#fff;border-right:1px solid #eef2f7;padding:12px 0 40px;scrollbar-width:thin;scrollbar-color:#dde3ec transparent}.blog-sidebar::-webkit-scrollbar{width:3px}.blog-sidebar::-webkit-scrollbar-thumb{background:#dde3ec;border-radius:2px}.sidebar-all-btn{display:flex;align-items:center;gap:10px;width:100%;padding:12px 16px;border:none;background:linear-gradient(135deg,#1B4B8C,#2563c7);color:#fff;cursor:pointer;font-size:0.88rem;font-weight:700;text-align:left}.sidebar-all-btn .sb-count{margin-left:auto;background:rgba(255,255,255,.25);color:#fff;font-size:0.7rem;padding:2px 7px;border-radius:10px;font-weight:700}.sidebar-divider{height:1px;background:#f0f4f8;margin:6px 0}.sidebar-section-title{font-size:0.6rem;font-weight:800;letter-spacing:.14em;text-transform:uppercase;color:#1ABC9C;padding:10px 16px 4px;margin:0}.sidebar-btn{display:flex;align-items:center;gap:9px;width:100%;padding:8px 16px;border:none;background:none;cursor:pointer;font-size:0.83rem;color:#4a5568;text-align:left;border-left:3px solid transparent;transition:all .12s;line-height:1.3}.sidebar-btn:hover{background:#f0f5ff;color:#1B4B8C}.sidebar-btn.active,.sidebar-all-btn.active{background:#eef4ff;color:#1B4B8C;font-weight:700;border-left:3px solid #1B4B8C}.sidebar-all-btn.active{background:linear-gradient(135deg,#1B4B8C,#2563c7);color:#fff;border-left:3px solid transparent}.sidebar-btn .sb-count{margin-left:auto;font-size:0.68rem;background:#f0f4f8;color:#8899aa;padding:2px 7px;border-radius:10px;font-weight:600;flex-shrink:0}.sidebar-btn.active .sb-count{background:#1B4B8C;color:#fff}.blog-main{flex:1;min-width:0}.results-bar{display:flex;align-items:center;justify-content:space-between;padding:14px 28px 10px;background:#fff;border-bottom:1px solid #eef2f7}.results-bar-left{font-size:0.82rem;color:#8899aa}.results-bar-left strong{color:#1B4B8C;font-weight:700}.results-bar-right{font-size:0.76rem;color:#aab4c0}.load-more-trigger{height:60px}.load-more-spinner{text-align:center;padding:20px;color:#8899aa;font-size:0.84rem;display:none}#mcatBtn{display:none;position:fixed;bottom:80px;right:16px;z-index:998;background:#1B4B8C;color:#fff;border:none;border-radius:50%;width:54px;height:54px;font-size:1.4rem;cursor:pointer;box-shadow:0 4px 20px rgba(27,75,140,.45);align-items:center;justify-content:center}#mcatOverlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.45);z-index:999}#mcatDrawer{position:fixed;bottom:0;left:0;right:0;z-index:1000;background:#fff;border-radius:20px 20px 0 0;max-height:78vh;overflow-y:auto;padding:0 0 24px;box-shadow:0 -8px 32px rgba(0,0,0,.15);transform:translateY(100%);transition:transform .3s ease}#mcatDrawer.open{transform:translateY(0)}.drawer-handle{width:36px;height:4px;background:#dde3ec;border-radius:2px;margin:12px auto 0}.drawer-hdr{padding:10px 20px 12px;border-bottom:1px solid #f0f4f8}.drawer-hdr h3{font-size:0.95rem;font-weight:700;color:#1A2332;margin:6px 0 2px}.drawer-hdr p{font-size:0.75rem;color:#8899aa;margin:0}.drawer-section-title{font-size:0.6rem;font-weight:800;letter-spacing:.14em;text-transform:uppercase;color:#1ABC9C;padding:12px 20px 4px}.drawer-btn{display:flex;align-items:center;gap:12px;width:100%;padding:11px 20px;border:none;background:none;cursor:pointer;font-size:0.88rem;color:#3D4A5C;border-bottom:1px solid #f5f8fc;text-align:left;transition:background .12s}.drawer-btn.active{background:#eef4ff;color:#1B4B8C;font-weight:700}.drawer-btn .db-count{margin-left:auto;font-size:0.72rem;background:#f0f4f8;color:#8899aa;padding:3px 9px;border-radius:10px;font-weight:600}.drawer-btn.active .db-count{background:#1B4B8C;color:#fff}.blog-container{max-width:none!important;padding:20px 28px 40px!important}.blog-grid{grid-template-columns:repeat(auto-fill,minmax(320px,1fr))!important;gap:22px!important}.blog-card{border-radius:16px!important;box-shadow:0 2px 12px rgba(0,0,0,.07)!important;transition:transform .2s,box-shadow .2s!important}.blog-card:hover{transform:translateY(-4px)!important;box-shadow:0 8px 28px rgba(27,75,140,.13)!important}@media(max-width:900px){.blog-sidebar{display:none}.blog-main{width:100%}.blog-layout{display:block}.blog-container{padding:14px 14px 32px!important}.blog-grid{grid-template-columns:1fr!important;gap:12px!important}.results-bar{padding:10px 14px 8px}#mcatBtn{display:flex}}'

$c = $c.Replace('</style>', $newCSS + '</style>')
Write-Host "1. CSS OK"

# ============================================================
# 2. SIDEBAR HTML — reemplaza <section class="filters">...</section>
# ============================================================
$sidebarHTML = '<div class="blog-layout"><aside class="blog-sidebar"><button class="sidebar-all-btn active" data-filter="all">&#128203; Todos los articulos<span class="sb-count">67</span></button><div class="sidebar-divider"></div><p class="sidebar-section-title">&#127758; Destinos</p><button class="sidebar-btn" data-filter="australia"><span>&#127462;&#127482;</span>Australia<span class="sb-count">9</span></button><button class="sidebar-btn" data-filter="irlanda"><span>&#127470;&#127466;</span>Irlanda<span class="sb-count">8</span></button><button class="sidebar-btn" data-filter="canada"><span>&#127464;&#127462;</span>Canada<span class="sb-count">6</span></button><button class="sidebar-btn" data-filter="europa"><span>&#127466;&#127482;</span>Europa<span class="sb-count">7</span></button><button class="sidebar-btn" data-filter="reino"><span>&#127468;&#127463;</span>Reino Unido<span class="sb-count">4</span></button><button class="sidebar-btn" data-filter="usa"><span>&#127482;&#127480;</span>Estados Unidos<span class="sb-count">3</span></button><button class="sidebar-btn" data-filter="malta"><span>&#127474;&#127481;</span>Malta<span class="sb-count">2</span></button><button class="sidebar-btn" data-filter="alemania"><span>&#127465;&#127466;</span>Alemania<span class="sb-count">2</span></button><div class="sidebar-divider"></div><p class="sidebar-section-title">&#128218; Temas</p><button class="sidebar-btn" data-filter="visa"><span>&#9992;&#65039;</span>Visas y Tramites<span class="sb-count">15</span></button><button class="sidebar-btn" data-filter="trabajo"><span>&#128188;</span>Trabajo y Salarios<span class="sb-count">12</span></button><button class="sidebar-btn" data-filter="economia"><span>&#128176;</span>Costos y Economia<span class="sb-count">13</span></button><button class="sidebar-btn" data-filter="comparativa"><span>&#9878;&#65039;</span>Comparativas<span class="sb-count">11</span></button><button class="sidebar-btn" data-filter="ciudad"><span>&#127961;&#65039;</span>Por Ciudad<span class="sb-count">10</span></button><button class="sidebar-btn" data-filter="ingles"><span>&#128218;</span>Ingles e Idiomas<span class="sb-count">9</span></button><button class="sidebar-btn" data-filter="proceso"><span>&#127891;</span>Proceso y Becas<span class="sb-count">8</span></button><button class="sidebar-btn" data-filter="prestigio"><span>&#127942;</span>Universidades<span class="sb-count">6</span></button></aside><div class="blog-main">'

# Encontrar y reemplazar la seccion de filtros completa
$filtersStart = $c.IndexOf('<section class="filters">')
$filtersEnd = $c.IndexOf('</section>', $filtersStart) + '</section>'.Length
if($filtersStart -ge 0 -and $filtersEnd -gt $filtersStart) {
    $c = $c.Substring(0, $filtersStart) + $sidebarHTML + $c.Substring($filtersEnd)
    Write-Host "2. Sidebar OK (reemplazado filters section)"
} else {
    Write-Host "2. ERROR: no se encontro filters section"
}

# ============================================================
# 3. Wrap blog-grid con ID y agregar results-bar + load trigger
# ============================================================
$c = $c.Replace('<div class="blog-grid">', '<div id="resultsBar" class="results-bar"><div class="results-bar-left"><strong id="resultsCount">67</strong> articulos encontrados</div><div class="results-bar-right">Scroll para ver mas</div></div><div class="blog-grid" id="blogGrid">')
Write-Host "3. Results bar OK"

# Agregar load trigger antes del cierre del blog-container
# El patron es: </div></div></section><section class="cta-section">
$closePattern = '</div></div></section><section class="cta-section">'
$closeParts = '</div><div class="load-more-trigger" id="loadTrigger"></div><div class="load-more-spinner" id="loadSpinner">Cargando mas articulos...</div></div></section></div></div><section class="cta-section">'
$c = $c.Replace($closePattern, $closeParts)
Write-Host "4. Load trigger + layout close OK"

# ============================================================
# 5. MOBILE DRAWER — antes de </body>
# ============================================================
$drawerHTML = '<button id="mcatBtn" aria-label="Categorias">&#9776;</button><div id="mcatOverlay"></div><div id="mcatDrawer" role="dialog" aria-label="Categorias del blog"><div class="drawer-handle"></div><div class="drawer-hdr"><h3>&#128203; Explorar articulos</h3><p>67 guias organizadas por tema</p></div><button class="drawer-btn active" data-filter="all">&#128203; Todos los articulos<span class="db-count">67</span></button><p class="drawer-section-title">&#127758; Destinos</p><button class="drawer-btn" data-filter="australia">&#127462;&#127482; Australia<span class="db-count">9</span></button><button class="drawer-btn" data-filter="irlanda">&#127470;&#127466; Irlanda<span class="db-count">8</span></button><button class="drawer-btn" data-filter="canada">&#127464;&#127462; Canada<span class="db-count">6</span></button><button class="drawer-btn" data-filter="europa">&#127466;&#127482; Europa<span class="db-count">7</span></button><button class="drawer-btn" data-filter="reino">&#127468;&#127463; Reino Unido<span class="db-count">4</span></button><button class="drawer-btn" data-filter="usa">&#127482;&#127480; Estados Unidos<span class="db-count">3</span></button><button class="drawer-btn" data-filter="malta">&#127474;&#127481; Malta<span class="db-count">2</span></button><button class="drawer-btn" data-filter="alemania">&#127465;&#127466; Alemania<span class="db-count">2</span></button><p class="drawer-section-title">&#128218; Temas</p><button class="drawer-btn" data-filter="visa">&#9992;&#65039; Visas y Tramites<span class="db-count">15</span></button><button class="drawer-btn" data-filter="trabajo">&#128188; Trabajo y Salarios<span class="db-count">12</span></button><button class="drawer-btn" data-filter="economia">&#128176; Costos y Economia<span class="db-count">13</span></button><button class="drawer-btn" data-filter="comparativa">&#9878;&#65039; Comparativas<span class="db-count">11</span></button><button class="drawer-btn" data-filter="ciudad">&#127961;&#65039; Por Ciudad<span class="db-count">10</span></button><button class="drawer-btn" data-filter="ingles">&#128218; Ingles e Idiomas<span class="db-count">9</span></button><button class="drawer-btn" data-filter="proceso">&#127891; Proceso y Becas<span class="db-count">8</span></button><button class="drawer-btn" data-filter="prestigio">&#127942; Universidades<span class="db-count">6</span></button></div>'

$c = $c.Replace('<div id="mobile-cta-bar"', $drawerHTML + '<div id="mobile-cta-bar"')
Write-Host "5. Mobile drawer OK"

# ============================================================
# 6. REEMPLAZAR JS DE FILTRADO con nuevo JS completo
# ============================================================
$oldJS = '<script>
const progressBar = document.getElementById(''reading-progress'');
window.addEventListener(''scroll'', () => {
const scroll = document.documentElement.scrollTop;
const height = document.documentElement.scrollHeight - window.innerHeight;
if (progressBar) progressBar.style.width = (scroll / height * 100) + ''%'';
});
const filterBtns = document.querySelectorAll(''.filter-btn'');
const blogCards = document.querySelectorAll(''.blog-card'');
filterBtns.forEach(btn => {
btn.addEventListener(''click'', () => {
filterBtns.forEach(b => b.classList.remove(''active''));
btn.classList.add(''active'');
const filter = btn.dataset.filter;
blogCards.forEach(card => {
if (filter === ''all'') {
card.style.display = ''block'';
} else {
const categories = card.dataset.categories;
if (categories && categories.includes(filter)) {
card.style.display = ''block'';
} else {
card.style.display = ''none'';
}
}
});
if (typeof gtag !== ''undefined'') {
gtag(''event'', ''blog_filter_used'', {
''event_category'': ''Blog'',
''event_label'': filter
});
}
});
});
document.querySelectorAll(''.blog-card-link'').forEach(link => {
link.addEventListener(''click'', function() {
const destino = this.closest(''.blog-card'').querySelector(''h3'').textContent;
if (typeof gtag !== ''undefined'') {
gtag(''event'', ''blog_article_click'', {
''event_category'': ''Blog'',
''event_label'': destino
});
}
});
});
document.querySelectorAll(''.blog-card-link'').forEach(link => {
link.addEventListener(''click'', function() {
if (typeof fbq !== ''undefined'') {
fbq(''track'', ''ViewContent'', {
content_name: this.closest(''.blog-card'').querySelector(''h3'').textContent,
content_category: ''Blog Article''
});
}
});
});
</script>'

$newJS = '<script>
(function(){
// Progress bar
var pb=document.getElementById("reading-progress");
window.addEventListener("scroll",function(){var s=document.documentElement.scrollTop,h=document.documentElement.scrollHeight-window.innerHeight;if(pb)pb.style.width=(s/h*100)+"%";},{passive:true});

// Filter mapping
var FM={
  "all":function(){return true;},
  "australia":function(c){return c.includes("australia");},
  "irlanda":function(c){return c.includes("irlanda");},
  "canada":function(c){return c.includes("canada");},
  "europa":function(c){return c.includes("europa");},
  "reino":function(c){return c.includes("reino");},
  "usa":function(c){return c.includes("usa");},
  "malta":function(c){return c.includes("malta");},
  "alemania":function(c){return c.includes("alemania");},
  "visa":function(c){return c.includes("visa");},
  "trabajo":function(c){return c.includes("trabajo");},
  "economia":function(c){return c.includes("economia")||c.includes("economico")||c.includes("costos");},
  "comparativa":function(c){return c.includes("comparativa");},
  "ciudad":function(c){return c.includes("ciudad");},
  "ingles":function(c){return c.includes("ingles")||c.includes("idiomas");},
  "proceso":function(c){return c.includes("proceso")||c.includes("practica")||c.includes("consejos")||c.includes("becas");},
  "prestigio":function(c){return c.includes("prestigio");}
};

var allCards=Array.from(document.querySelectorAll(".blog-card"));
var filteredCards=allCards.slice();
var visibleCount=15;
var PAGE=12;
var currentFilter="all";
var countEl=document.getElementById("resultsCount");

// Initial: hide cards beyond first 15
allCards.forEach(function(c,i){c.style.display=i<15?"block":"none";});

function setActive(filter){
  // Sidebar
  document.querySelectorAll(".sidebar-btn,.sidebar-all-btn").forEach(function(b){
    b.classList.toggle("active",b.dataset.filter===filter);
  });
  // Drawer
  document.querySelectorAll(".drawer-btn").forEach(function(b){
    b.classList.toggle("active",b.dataset.filter===filter);
  });
}

function applyFilter(filter){
  currentFilter=filter;
  var fn=FM[filter]||function(c){return c.includes(filter);};
  filteredCards=allCards.filter(function(card){
    return fn(card.dataset.categories||"");
  });
  visibleCount=15;
  allCards.forEach(function(c){c.style.display="none";});
  filteredCards.slice(0,visibleCount).forEach(function(c){c.style.display="block";});
  if(countEl)countEl.textContent=filteredCards.length;
  setActive(filter);
  if(typeof gtag!=="undefined")gtag("event","blog_filter_used",{"event_category":"Blog","event_label":filter});
  window.scrollTo({top:document.getElementById("blogGrid").offsetTop-80,behavior:"smooth"});
}

function loadMore(){
  if(visibleCount>=filteredCards.length)return;
  var next=filteredCards.slice(visibleCount,visibleCount+PAGE);
  next.forEach(function(c){c.style.display="block";});
  visibleCount+=PAGE;
}

// IntersectionObserver for infinite scroll
var trigger=document.getElementById("loadTrigger");
if(trigger && window.IntersectionObserver){
  var obs=new IntersectionObserver(function(entries){
    if(entries[0].isIntersecting)loadMore();
  },{rootMargin:"300px"});
  obs.observe(trigger);
}

// Wire sidebar + drawer buttons
document.querySelectorAll(".sidebar-btn,.sidebar-all-btn,.drawer-btn").forEach(function(btn){
  btn.addEventListener("click",function(){
    var filter=this.dataset.filter||"all";
    applyFilter(filter);
    // Close drawer if open
    var drawer=document.getElementById("mcatDrawer");
    var overlay=document.getElementById("mcatOverlay");
    if(drawer){drawer.classList.remove("open");}
    if(overlay){overlay.style.display="none";}
  });
});

// Mobile drawer
var mcatBtn=document.getElementById("mcatBtn");
var mcatDrawer=document.getElementById("mcatDrawer");
var mcatOverlay=document.getElementById("mcatOverlay");
if(mcatBtn&&mcatDrawer){
  mcatBtn.addEventListener("click",function(){
    mcatDrawer.classList.add("open");
    mcatOverlay.style.display="block";
  });
  mcatOverlay.addEventListener("click",function(){
    mcatDrawer.classList.remove("open");
    mcatOverlay.style.display="none";
  });
}

// Article click tracking
document.querySelectorAll(".blog-card-link").forEach(function(link){
  link.addEventListener("click",function(){
    var t=this.closest(".blog-card").querySelector("h3");
    var name=t?t.textContent:"";
    if(typeof gtag!=="undefined")gtag("event","blog_article_click",{"event_category":"Blog","event_label":name});
    if(typeof fbq!=="undefined")fbq("track","ViewContent",{content_name:name,content_category:"Blog Article"});
  });
});
})();
</script>'

# Buscar y reemplazar el bloque de script JS
$scriptStart = $c.IndexOf('<script>')
# Necesitamos el script en posicion ~126721 (el de filtros)
# Buscar el script que contiene "filterBtns"
$filterScriptIdx = $c.IndexOf('const filterBtns')
if($filterScriptIdx -lt 0) {
    $filterScriptIdx = $c.IndexOf('filterBtns')
}
# Encontrar el <script> antes de filterBtns
$scriptTagBefore = $c.LastIndexOf('<script>', $filterScriptIdx)
$scriptTagEnd = $c.IndexOf('</script>', $filterScriptIdx) + '</script>'.Length
if($scriptTagBefore -ge 0 -and $scriptTagEnd -gt $scriptTagBefore) {
    $c = $c.Substring(0,$scriptTagBefore) + $newJS + $c.Substring($scriptTagEnd)
    Write-Host "6. JS OK (reemplazado filter script)"
} else {
    Write-Host "6. ERROR: no se encontro filter script"
}

# ============================================================
# 7. GUARDAR
# ============================================================
[System.IO.File]::WriteAllText($f, $c, [System.Text.Encoding]::UTF8)
Write-Host "7. Archivo guardado OK"
Write-Host "Tamano final: $($c.Length) chars"
