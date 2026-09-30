// Lead capture widget (WhatsApp) — Navia Global
// Usage: include this script and add <div class="navia-email-capture" data-topic="Australia"></div>
(function(){
  var style = document.createElement('style');
  style.textContent = [
    '.navia-ec{background:linear-gradient(135deg,#2c3e50,#1B4B8C);border-radius:16px;padding:36px 32px;margin:40px 0;color:#fff;text-align:center}',
    '.navia-ec-tag{display:inline-block;background:rgba(0,217,163,.15);border:1px solid rgba(0,217,163,.3);color:#00D9A3;font-size:.75rem;font-weight:700;text-transform:uppercase;letter-spacing:.08em;padding:4px 14px;border-radius:20px;margin-bottom:14px}',
    '.navia-ec h3{font-size:1.25rem;font-weight:800;margin-bottom:8px}',
    '.navia-ec p{opacity:.85;font-size:.92rem;max-width:480px;margin:0 auto 20px;line-height:1.65}',
    '.navia-ec-form{display:flex;flex-direction:column;gap:10px;max-width:420px;margin:0 auto}',
    '.navia-ec-form input{width:100%;padding:13px 16px;border-radius:8px;border:none;font-size:.95rem;outline:none;font-family:inherit}',
    '.navia-ec-form button{background:#25D366;color:#fff;border:none;padding:14px 22px;border-radius:8px;font-weight:800;font-size:.95rem;cursor:pointer;white-space:nowrap;font-family:inherit;transition:transform .15s;display:flex;align-items:center;justify-content:center;gap:9px}',
    '.navia-ec-form button:hover{transform:translateY(-1px)}',
    '.navia-ec-form button svg{width:20px;height:20px;fill:#fff}',
    '.navia-ec-ok{display:none;margin-top:12px;font-size:.95rem;color:#00D9A3;font-weight:700}',
    '.navia-ec-trust{margin-top:12px;font-size:.75rem;opacity:.55}'
  ].join('');
  document.head.appendChild(style);

  var WA = '573014430722';
  var WA_SVG = '<svg viewBox="0 0 32 32"><path d="M16 0C7.164 0 0 7.163 0 16c0 2.826.736 5.587 2.138 8.024L.05 31.95l8.075-2.05A15.94 15.94 0 0016 32c8.837 0 16-7.163 16-16S24.837 0 16 0zm9.338 19.73c-.404 1.14-2.017 2.002-2.792 2.116-.711.107-1.59.15-2.556-.16-.585-.186-1.336-.434-2.298-.849-4.045-1.746-6.687-5.818-6.888-6.088-.203-.27-1.65-2.19-1.65-4.176 0-1.987 1.043-2.964 1.413-3.367.37-.404 1.08-.505 1.077-.505.269 0 .539.003.774.014.248.012.58-.095.908.692.336.807.93 2.79 1.012 2.993.101.202.168.437.034.707-.135.27-.202.437-.404.673-.202.236-.424.526-.606.707-.202.201-.412.42-.177.823.235.403 1.046 1.724 2.246 2.794 1.541 1.375 2.841 1.801 3.244 2.003.404.203.638.169.874-.101.235-.27 1.009-1.179 1.28-1.582.27-.404.538-.337.908-.202.369.134 2.353 1.11 2.757 1.312.404.202.673.302.774.472.102.17.102.977-.236 1.92z"/></svg>';

  function buildWidget(el){
    var topic = el.getAttribute('data-topic') || 'el exterior';
    el.className = 'navia-ec';
    el.innerHTML = [
      '<div class="navia-ec-tag">🎓 Asesoría 100% gratuita</div>',
      '<h3>¿Quieres estudiar en '+topic+'? Te ayudamos gratis</h3>',
      '<p>Déjanos tu nombre y WhatsApp. Un asesor te contacta hoy con costos reales, proceso de visa y los próximos pasos — sin compromiso.</p>',
      '<form class="navia-ec-form">',
        '<input type="text" name="nombre" placeholder="Tu nombre" required autocomplete="name">',
        '<input type="tel" name="whatsapp" placeholder="Tu WhatsApp (con código de país)" required autocomplete="tel">',
        '<button type="submit">'+WA_SVG+'Quiero mi asesoría gratis</button>',
      '</form>',
      '<div class="navia-ec-ok">✅ ¡Listo! Te abrimos WhatsApp para que hablemos ahora mismo.</div>',
      '<p class="navia-ec-trust">Respuesta en menos de 2 horas · Sin costo · Sin compromiso</p>'
    ].join('');

    var form = el.querySelector('form');
    form.addEventListener('submit', function(e){
      e.preventDefault();
      var nombre = form.querySelector('[name=nombre]').value.trim();
      var whatsapp = form.querySelector('[name=whatsapp]').value.trim();
      if(!nombre || !whatsapp) return;
      // Track
      if(typeof fbq === 'function') fbq('track','Lead',{content_name:'Blog Lead',content_category:topic});
      if(typeof gtag === 'function') gtag('event','generate_lead',{event_category:'Blog',event_label:topic});
      try{fetch('https://primary-production-1264d.up.railway.app/webhook/lead-web',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({nombre:nombre,whatsapp:whatsapp,destino:topic,origen:'blog-capture'})}).catch(function(){});}catch(_){}
      // Guardar lead en Formspree
      fetch('https://formspree.io/f/xdkpereb',{
        method:'POST',
        body: JSON.stringify({nombre:nombre, whatsapp:whatsapp, tipo:'lead-blog', tema:topic, _subject:'Nuevo lead blog: '+topic}),
        headers:{'Content-Type':'application/json','Accept':'application/json'}
      }).catch(function(){});
      // Mostrar confirmación y abrir WhatsApp con mensaje listo
      form.style.display='none';
      el.querySelector('.navia-ec-ok').style.display='block';
      var msg = 'Hola, soy '+nombre+'. Quiero información para estudiar en '+topic+'.';
      window.open('https://wa.me/'+WA+'?text='+encodeURIComponent(msg),'_blank');
    });
  }

  function init(){
    document.querySelectorAll('.navia-email-capture').forEach(buildWidget);
  }

  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
