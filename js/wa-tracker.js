// WhatsApp click tracking — Navia Global
// Fires fbq Lead + gtag generate_lead on every wa.me click
(function(){
  function trackWA(e){
    var url = this.href || '';
    var label = this.dataset.dest || document.title;
    // Meta Pixel
    if(typeof fbq === 'function'){
      fbq('track','Lead',{content_name:'WhatsApp',content_category:label});
      fbq('track','InitiateContact',{content_name:'WhatsApp',content_category:label});
    }
    // Google Analytics
    if(typeof gtag === 'function'){
      gtag('event','generate_lead',{event_category:'WhatsApp',event_label:label,value:1});
    }
  }
  function init(){
    document.querySelectorAll('a[href*="wa.me"]').forEach(function(a){
      a.addEventListener('click', trackWA);
    });
  }
  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
