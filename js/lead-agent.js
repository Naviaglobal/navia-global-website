// Navia Global — Lead Agent v1
// Tracking & micro-interactions for country pages
(function(){
  // Track WhatsApp CTA clicks
  document.querySelectorAll('a[href*="wa.me"]').forEach(function(el){
    el.addEventListener('click',function(){
      if(typeof gtag==='function') gtag('event','whatsapp_click',{event_category:'CTA',event_label:document.title});
      if(typeof fbq==='function') fbq('track','Contact');
    });
  });
  // Track contact form CTA clicks
  document.querySelectorAll('a[href*="contacto"]').forEach(function(el){
    el.addEventListener('click',function(){
      if(typeof gtag==='function') gtag('event','contacto_click',{event_category:'CTA',event_label:document.title});
    });
  });
})();
