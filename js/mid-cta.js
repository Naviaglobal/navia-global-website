(function(){
  var DEST = {
    'Australia':      {url:'/australia/',      flag:'🇦🇺', name:'Australia',     msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Australia'},
    'Irlanda':        {url:'/irlanda/',        flag:'🇮🇪', name:'Irlanda',       msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Irlanda'},
    'Canada':         {url:'/canada/',         flag:'🇨🇦', name:'Canadá',        msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Canad%C3%A1'},
    'Canadá':         {url:'/canada/',         flag:'🇨🇦', name:'Canadá',        msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Canad%C3%A1'},
    'Malta':          {url:'/malta/',          flag:'🇲🇹', name:'Malta',         msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Malta'},
    'Dubai':          {url:'/dubai/',          flag:'🇦🇪', name:'Dubái',         msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Dub%C3%A1i'},
    'Nueva Zelanda':  {url:'/nueva-zelanda/',  flag:'🇳🇿', name:'Nueva Zelanda', msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Nueva%20Zelanda'},
    'Reino Unido':    {url:'/reino-unido/',    flag:'🇬🇧', name:'Reino Unido',   msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20el%20Reino%20Unido'},
    'Estados Unidos': {url:'/estados-unidos/', flag:'🇺🇸', name:'Estados Unidos',msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Estados%20Unidos'},
    'Francia':        {url:'/francia/',        flag:'🇫🇷', name:'Francia',       msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Francia'},
    'Alemania':       {url:'/alemania/',       flag:'🇩🇪', name:'Alemania',      msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Alemania'},
    'Malta vs Irlanda':{url:'/malta/',         flag:'🇲🇹', name:'Malta',         msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Malta%20o%20Irlanda'},
    'Australia vs Irlanda':{url:'/australia/', flag:'🇦🇺', name:'Australia',     msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Australia%20o%20Irlanda'},
    'Australia vs Canada':{url:'/australia/',  flag:'🇦🇺', name:'Australia',     msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Australia%20o%20Canad%C3%A1'},
    'Canada vs Reino Unido':{url:'/canada/',   flag:'🇨🇦', name:'Canadá',        msg:'Hola%2C%20quiero%20información%20para%20estudiar%20en%20Canad%C3%A1%20o%20el%20Reino%20Unido'}
  };

  var DEFAULT_MSG = 'Hola%2C%20quiero%20información%20para%20estudiar%20en%20el%20exterior';
  var WA_BASE = 'https://wa.me/573014430722?text=';

  var captureDiv = document.querySelector('.navia-email-capture');
  var topic = captureDiv ? captureDiv.getAttribute('data-topic') : null;
  var dest = topic ? DEST[topic] : null;

  /* ── STYLES ── */
  var css = [
    '.navia-dest-banner{margin:24px 0;border-radius:10px;background:rgba(0,217,163,.07);border:1px solid rgba(0,217,163,.25);overflow:hidden}',
    '.navia-dest-banner a{display:flex;align-items:center;justify-content:space-between;padding:13px 18px;text-decoration:none;color:#00D9A3;font-size:.9rem;font-weight:600;gap:12px;transition:background .15s}',
    '.navia-dest-banner a:hover{background:rgba(0,217,163,.13)}',
    '.navia-dest-banner a strong{color:#fff}',
    '.navia-dest-arr{font-size:.8rem;opacity:.7;white-space:nowrap;color:rgba(255,255,255,.5)}',

    '.navia-mid-cta{margin:40px 0;border-radius:14px;border:1.5px solid rgba(0,217,163,.35);overflow:hidden;background:linear-gradient(135deg,#071d30 0%,#0b2c4a 100%)}',
    '.navia-mid-cta-inner{padding:26px 30px}',
    '@media(max-width:620px){.navia-mid-cta-inner{padding:20px 18px}}',
    '.navia-mid-label{font-size:.62rem;font-weight:800;letter-spacing:.14em;color:#00D9A3;text-transform:uppercase;margin-bottom:7px}',
    '.navia-mid-title{font-size:1.2rem;font-weight:800;color:#fff;line-height:1.3;margin-bottom:7px}',
    '.navia-mid-sub{font-size:.85rem;color:rgba(255,255,255,.6);margin-bottom:18px;line-height:1.5}',
    '.navia-mid-btns{display:flex;flex-wrap:wrap;gap:10px;align-items:center}',
    '.navia-mid-wa{display:inline-flex;align-items:center;gap:7px;background:#25D366;color:#fff;padding:11px 22px;border-radius:8px;font-weight:700;font-size:.88rem;text-decoration:none;transition:opacity .2s;cursor:pointer}',
    '.navia-mid-wa:hover{opacity:.88}',
    '.navia-mid-link{display:inline-block;color:rgba(0,217,163,.85);font-size:.85rem;font-weight:600;text-decoration:none;padding:10px 4px;transition:opacity .2s}',
    '.navia-mid-link:hover{opacity:.7}'
  ].join('');
  var s = document.createElement('style');
  s.textContent = css;
  document.head.appendChild(s);

  /* ── #4: DESTINATION BANNER after first h2 ── */
  if (dest) {
    var h2s = document.querySelectorAll('.content h2, .container h2, article h2');
    var firstH2 = h2s[0];
    if (firstH2) {
      var banner = document.createElement('div');
      banner.className = 'navia-dest-banner';
      banner.innerHTML =
        '<a href="' + dest.url + '">' +
          '<span>' + dest.flag + ' Página principal: <strong>' + dest.name + '</strong> — costos, visas, proceso completo</span>' +
          '<span class="navia-dest-arr">Ver destino →</span>' +
        '</a>';
      firstH2.parentNode.insertBefore(banner, firstH2.nextSibling);
    }
  }

  /* ── #2: MID-ARTICLE CTA after 3rd h2 (fallback: 2nd, then 1st) ── */
  var allH2s = document.querySelectorAll('.content h2, .container h2, article h2');
  var anchor = allH2s[2] || allH2s[1] || allH2s[0];

  if (anchor) {
    var waUrl = WA_BASE + (dest ? dest.msg : DEFAULT_MSG);
    var questionText = dest
      ? '¿Listo para estudiar en ' + dest.name + '?'
      : '¿Listo para estudiar en el exterior?';

    var box = document.createElement('div');
    box.className = 'navia-mid-cta';
    box.innerHTML =
      '<div class="navia-mid-cta-inner">' +
        '<p class="navia-mid-label">Asesoría gratuita · Navia Global</p>' +
        '<h3 class="navia-mid-title">' + questionText + '</h3>' +
        '<p class="navia-mid-sub">Te ayudamos a elegir escuela, tramitar tu visa y planear los costos — sin cobrarte nada. Respondemos en menos de 2 horas.</p>' +
        '<div class="navia-mid-btns">' +
          '<a href="' + waUrl + '" target="_blank" rel="noopener" class="navia-mid-wa">' +
            '<svg width="18" height="18" viewBox="0 0 32 32" fill="white"><path d="M16 0C7.164 0 0 7.164 0 16c0 2.828.737 5.489 2.022 7.8L.068 31.53l8.006-2.1C10.284 30.736 13.067 32 16 32c8.836 0 16-7.164 16-16S24.836 0 16 0zm0 29.333c-2.543 0-4.925-.711-6.952-1.937l-.498-.296-5.147 1.349 1.371-5.009-.325-.516C3.036 21.059 2.667 18.56 2.667 16c0-7.364 5.969-13.333 13.333-13.333S29.333 8.636 29.333 16 23.364 29.333 16 29.333z"/><path d="M22.667 18.667c-.367-.184-2.167-1.067-2.5-1.2-.333-.117-.583-.184-.833.2-.25.367-.95 1.2-1.167 1.45-.217.25-.433.283-.8.1-.367-.184-1.55-.572-2.95-1.821-1.092-.972-1.829-2.171-2.042-2.538-.213-.367-.023-.566.161-.748.165-.164.367-.428.55-.641.183-.213.244-.367.367-.611.122-.244.061-.458-.031-.641-.092-.184-.827-1.996-1.133-2.733-.298-.714-.601-.616-.827-.628-.214-.01-.458-.012-.703-.012s-.641.092-.977.458c-.336.367-1.283 1.254-1.283 3.058s1.314 3.546 1.497 3.79c.184.244 2.586 3.947 6.267 5.537.875.377 1.559.602 2.091.771.879.28 1.679.24 2.311.146.705-.106 2.167-.886 2.472-1.741.306-.855.306-1.588.214-1.741-.091-.153-.336-.244-.703-.428z"/></svg>' +
            'Escribir por WhatsApp' +
          '</a>' +
          (dest ? '<a href="' + dest.url + '" class="navia-mid-link">Ver guía completa de ' + dest.name + ' →</a>' : '') +
        '</div>' +
      '</div>';

    anchor.parentNode.insertBefore(box, anchor);

    /* tracking */
    var waBtn = box.querySelector('.navia-mid-wa');
    if (waBtn) {
      waBtn.addEventListener('click', function(){
        if (typeof fbq === 'function') {
          fbq('track', 'Lead', {content_name: 'MidCTA', content_category: topic || 'general'});
          fbq('track', 'InitiateContact', {content_name: 'MidCTA'});
        }
        if (typeof gtag === 'function') {
          gtag('event', 'generate_lead', {event_category: 'MidCTA', event_label: topic || 'general'});
        }
      });
    }
  }
})();
