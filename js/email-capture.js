// Email capture widget — Navia Global
// Usage: include this script and add <div class="navia-email-capture" data-topic="Australia"></div>
(function(){
  var style = document.createElement('style');
  style.textContent = [
    '.navia-ec{background:linear-gradient(135deg,#0B2C4A,#1B4B8C);border-radius:16px;padding:36px 32px;margin:40px 0;color:#fff;text-align:center}',
    '.navia-ec-tag{display:inline-block;background:rgba(0,217,163,.15);border:1px solid rgba(0,217,163,.3);color:#00D9A3;font-size:.75rem;font-weight:700;text-transform:uppercase;letter-spacing:.08em;padding:4px 14px;border-radius:20px;margin-bottom:14px}',
    '.navia-ec h3{font-size:1.25rem;font-weight:800;margin-bottom:8px}',
    '.navia-ec p{opacity:.85;font-size:.92rem;max-width:480px;margin:0 auto 20px;line-height:1.65}',
    '.navia-ec-form{display:flex;gap:10px;justify-content:center;flex-wrap:wrap;max-width:460px;margin:0 auto}',
    '.navia-ec-form input{flex:1;min-width:200px;padding:12px 16px;border-radius:8px;border:none;font-size:.95rem;outline:none;font-family:inherit}',
    '.navia-ec-form button{background:#00D9A3;color:#0B2C4A;border:none;padding:12px 22px;border-radius:8px;font-weight:800;font-size:.9rem;cursor:pointer;white-space:nowrap;font-family:inherit;transition:transform .15s}',
    '.navia-ec-form button:hover{transform:translateY(-1px)}',
    '.navia-ec-ok{display:none;margin-top:12px;font-size:.92rem;color:#00D9A3;font-weight:700}',
    '.navia-ec-trust{margin-top:12px;font-size:.75rem;opacity:.55}'
  ].join('');
  document.head.appendChild(style);

  function buildWidget(el){
    var topic = el.getAttribute('data-topic') || 'el exterior';
    el.className = 'navia-ec';
    el.innerHTML = [
      '<div class="navia-ec-tag">🎁 Recurso gratuito</div>',
      '<h3>Recibe la Guía completa para estudiar en '+topic+' 2026</h3>',
      '<p>Costos reales, proceso de visa, trabajo y todo lo que necesitas saber antes de decidir. Gratis en tu correo.</p>',
      '<form class="navia-ec-form">',
        '<input type="email" placeholder="tu@correo.com" required autocomplete="email">',
        '<button type="submit">Enviar guía →</button>',
      '</form>',
      '<div class="navia-ec-ok">✅ ¡Listo! Revisa tu correo en los próximos minutos.</div>',
      '<p class="navia-ec-trust">Sin spam · Puedes cancelar cuando quieras</p>'
    ].join('');

    var form = el.querySelector('form');
    form.addEventListener('submit', function(e){
      e.preventDefault();
      var email = form.querySelector('input').value.trim();
      if(!email) return;
      // Track
      if(typeof fbq === 'function') fbq('track','Lead',{content_name:'Email Capture',content_category:topic});
      if(typeof gtag === 'function') gtag('event','generate_lead',{event_category:'Email',event_label:topic});
      // Submit to Formspree
      fetch('https://formspree.io/f/xdkpereb',{
        method:'POST',
        body: JSON.stringify({email:email, tipo:'newsletter', tema:topic, _subject:'Suscripción guía: '+topic}),
        headers:{'Content-Type':'application/json','Accept':'application/json'}
      }).then(function(){
        form.style.display='none';
        el.querySelector('.navia-ec-ok').style.display='block';
      }).catch(function(){
        // fallback: redirect to WhatsApp
        window.open('https://wa.me/573014430722?text=Hola%2C%20quiero%20la%20gu%C3%ADa%20de%20'+encodeURIComponent(topic),'_blank');
      });
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