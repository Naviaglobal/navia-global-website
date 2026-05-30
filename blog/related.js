(function(){
var MAP={
  'estudiar-australia-colombia-2026':['visa-estudiante-australia-2026','cuanto-gana-colombiano-australia','sydney-vs-melbourne-colombia','australia-vs-irlanda-colombianos-2026','trabajar-mientras-estudias-exterior'],
  'visa-estudiante-australia-2026':['estudiar-australia-colombia-2026','requisitos-visa-trabajo-australia-colombia','cuanto-gana-colombiano-australia','diferencia-visa-estudiante-working-holiday','working-holiday-visa-colombia'],
  'sydney-vs-melbourne-colombia':['estudiar-australia-colombia-2026','estudiar-ingles-sydney-colombia','estudiar-ingles-melbourne-colombia','australia-vs-irlanda-colombianos-2026','vuelo-colombia-australia-precio-duracion-2026'],
  'cuanto-gana-colombiano-australia':['estudiar-australia-colombia-2026','visa-estudiante-australia-2026','trabajar-mientras-estudias-exterior','requisitos-visa-trabajo-australia-colombia','costo-estudiar-exterior-2026'],
  'requisitos-visa-trabajo-australia-colombia':['visa-estudiante-australia-2026','estudiar-australia-colombia-2026','working-holiday-visa-colombia','diferencia-visa-estudiante-working-holiday','cuanto-gana-colombiano-australia'],
  'australia-vs-irlanda-colombianos-2026':['estudiar-australia-colombia-2026','estudiar-irlanda-colombia-2026','australia-vs-canada-colombianos-2026','mejor-pais-estudiar-ingles-colombia-2026','costo-estudiar-exterior-2026'],
  'australia-vs-canada-colombianos-2026':['estudiar-australia-colombia-2026','estudiar-canada-colombia-2026','australia-vs-irlanda-colombianos-2026','mejor-pais-estudiar-ingles-colombia-2026','toronto-vs-vancouver-colombia'],
  'vuelo-colombia-australia-precio-duracion-2026':['estudiar-australia-colombia-2026','visa-estudiante-australia-2026','costo-estudiar-exterior-2026','estudiar-exterior-sin-dinero-colombia-2026','como-financiar-estudios-exterior-colombia'],
  'estudiar-ingles-sydney-colombia':['estudiar-australia-colombia-2026','sydney-vs-melbourne-colombia','estudiar-ingles-melbourne-colombia','cuanto-gana-colombiano-australia','alojamiento-estudiar-exterior-colombia'],
  'estudiar-ingles-melbourne-colombia':['estudiar-australia-colombia-2026','sydney-vs-melbourne-colombia','estudiar-ingles-sydney-colombia','cuanto-gana-colombiano-australia','alojamiento-estudiar-exterior-colombia'],
  'estudiar-irlanda-colombia-2026':['visa-estudiante-irlanda-colombia-2026','estudiar-ingles-dublin-colombia','dublin-vs-cork-colombia','australia-vs-irlanda-colombianos-2026','vivir-trabajar-irlanda-colombianos-2026'],
  'visa-estudiante-irlanda-colombia-2026':['estudiar-irlanda-colombia-2026','estudiar-ingles-dublin-colombia','emigrar-irlanda-colombia-proceso-completo','diferencia-visa-estudiante-working-holiday','costo-estudiar-ingles-irlanda-mensualmente'],
  'dublin-vs-cork-colombia':['estudiar-irlanda-colombia-2026','estudiar-ingles-dublin-colombia','estudiar-ingles-cork-colombia','visa-estudiante-irlanda-colombia-2026','malta-vs-irlanda-colombianos-2026'],
  'estudiar-ingles-dublin-colombia':['estudiar-irlanda-colombia-2026','dublin-vs-cork-colombia','visa-estudiante-irlanda-colombia-2026','costo-estudiar-ingles-irlanda-mensualmente','alojamiento-estudiar-exterior-colombia'],
  'estudiar-ingles-cork-colombia':['estudiar-irlanda-colombia-2026','dublin-vs-cork-colombia','visa-estudiante-irlanda-colombia-2026','alojamiento-estudiar-exterior-colombia','costo-estudiar-ingles-irlanda-mensualmente'],
  'vivir-trabajar-irlanda-colombianos-2026':['estudiar-irlanda-colombia-2026','emigrar-irlanda-colombia-proceso-completo','visa-estudiante-irlanda-colombia-2026','trabajar-mientras-estudias-exterior','como-conseguir-trabajo-extranjero-colombia'],
  'emigrar-irlanda-colombia-proceso-completo':['estudiar-irlanda-colombia-2026','vivir-trabajar-irlanda-colombianos-2026','visa-estudiante-irlanda-colombia-2026','costo-estudiar-ingles-irlanda-mensualmente','como-conseguir-trabajo-extranjero-colombia'],
  'costo-estudiar-ingles-irlanda-mensualmente':['estudiar-irlanda-colombia-2026','visa-estudiante-irlanda-colombia-2026','costo-estudiar-exterior-2026','malta-vs-irlanda-colombianos-2026','como-financiar-estudios-exterior-colombia'],
  'malta-vs-irlanda-colombianos-2026':['estudiar-malta-colombia-2026','estudiar-irlanda-colombia-2026','visa-estudiante-malta-colombia-2026','mejor-pais-estudiar-ingles-colombia-2026','costo-estudiar-exterior-2026'],
  'estudiar-malta-colombia-2026':['visa-estudiante-malta-colombia-2026','malta-vs-irlanda-colombianos-2026','estudiar-ingles-malta-opiniones-colombianos','visa-schengen-colombianos-2026','costo-estudiar-exterior-2026'],
  'visa-estudiante-malta-colombia-2026':['estudiar-malta-colombia-2026','malta-vs-irlanda-colombianos-2026','visa-schengen-colombianos-2026','estudiar-ingles-malta-opiniones-colombianos','diferencia-visa-estudiante-working-holiday'],
  'estudiar-ingles-malta-opiniones-colombianos':['estudiar-malta-colombia-2026','visa-estudiante-malta-colombia-2026','malta-vs-irlanda-colombianos-2026','alojamiento-estudiar-exterior-colombia','costo-estudiar-exterior-2026'],
  'visa-schengen-colombianos-2026':['estudiar-malta-colombia-2026','estudiar-alemania-colombia-2026','estudiar-francia-colombia-2026','visa-estudiante-alemania-colombia-2026','estudiar-gratis-alemania-colombianos'],
  'estudiar-canada-colombia-2026':['visa-estudiante-canada-2026','toronto-vs-vancouver-colombia','australia-vs-canada-colombianos-2026','canada-vs-reino-unido-colombianos-2026','vivir-estudiar-canada-colombianos'],
  'visa-estudiante-canada-2026':['estudiar-canada-colombia-2026','toronto-vs-vancouver-colombia','vivir-estudiar-canada-colombianos','diferencia-visa-estudiante-working-holiday','universidades-canada-colombianos-sin-ielts'],
  'toronto-vs-vancouver-colombia':['estudiar-canada-colombia-2026','estudiar-ingles-toronto-colombia','estudiar-ingles-vancouver-colombia','visa-estudiante-canada-2026','australia-vs-canada-colombianos-2026'],
  'estudiar-ingles-toronto-colombia':['estudiar-canada-colombia-2026','toronto-vs-vancouver-colombia','visa-estudiante-canada-2026','alojamiento-estudiar-exterior-colombia','trabajar-mientras-estudias-exterior'],
  'estudiar-ingles-vancouver-colombia':['estudiar-canada-colombia-2026','toronto-vs-vancouver-colombia','visa-estudiante-canada-2026','alojamiento-estudiar-exterior-colombia','trabajar-mientras-estudias-exterior'],
  'vivir-estudiar-canada-colombianos':['estudiar-canada-colombia-2026','visa-estudiante-canada-2026','universidades-canada-colombianos-sin-ielts','como-conseguir-trabajo-extranjero-colombia','maestrias-exterior-colombia-2026'],
  'universidades-canada-colombianos-sin-ielts':['estudiar-canada-colombia-2026','maestrias-exterior-colombia-2026','visa-estudiante-canada-2026','diferencia-ielts-toefl-colombia','ingles-b2-cuanto-tiempo-colombia'],
  'canada-vs-reino-unido-colombianos-2026':['estudiar-canada-colombia-2026','estudiar-reino-unido-colombia-2026','visa-estudiante-canada-2026','visa-estudiante-reino-unido-colombia-2026','mejor-pais-estudiar-ingles-colombia-2026'],
  'estudiar-reino-unido-colombia-2026':['visa-estudiante-reino-unido-colombia-2026','estudiar-ingles-londres-colombia','londres-vs-manchester-colombia','canada-vs-reino-unido-colombianos-2026','maestrias-exterior-colombia-2026'],
  'visa-estudiante-reino-unido-colombia-2026':['estudiar-reino-unido-colombia-2026','estudiar-ingles-londres-colombia','diferencia-visa-estudiante-working-holiday','maestrias-exterior-colombia-2026','ingles-b2-cuanto-tiempo-colombia'],
  'londres-vs-manchester-colombia':['estudiar-reino-unido-colombia-2026','estudiar-ingles-londres-colombia','estudiar-ingles-manchester-colombia','visa-estudiante-reino-unido-colombia-2026','mejor-pais-estudiar-ingles-colombia-2026'],
  'estudiar-ingles-londres-colombia':['estudiar-reino-unido-colombia-2026','londres-vs-manchester-colombia','visa-estudiante-reino-unido-colombia-2026','alojamiento-estudiar-exterior-colombia','costo-estudiar-exterior-2026'],
  'estudiar-ingles-manchester-colombia':['estudiar-reino-unido-colombia-2026','londres-vs-manchester-colombia','visa-estudiante-reino-unido-colombia-2026','alojamiento-estudiar-exterior-colombia','costo-estudiar-exterior-2026'],
  'estudiar-nueva-zelanda-colombia-2026':['visa-estudiante-nueva-zelanda-colombia-2026','estudiar-ingles-auckland-colombia','australia-vs-irlanda-colombianos-2026','trabajar-mientras-estudias-exterior','costo-estudiar-exterior-2026'],
  'visa-estudiante-nueva-zelanda-colombia-2026':['estudiar-nueva-zelanda-colombia-2026','estudiar-ingles-auckland-colombia','diferencia-visa-estudiante-working-holiday','working-holiday-visa-colombia','costo-estudiar-exterior-2026'],
  'estudiar-ingles-auckland-colombia':['estudiar-nueva-zelanda-colombia-2026','visa-estudiante-nueva-zelanda-colombia-2026','alojamiento-estudiar-exterior-colombia','trabajar-mientras-estudias-exterior','costo-estudiar-exterior-2026'],
  'estudiar-estados-unidos-colombia-2026':['visa-estudiante-estados-unidos-colombia-2026','estudiar-ingles-nueva-york-colombia','nueva-york-vs-miami-colombia','diferencia-ielts-toefl-colombia','maestrias-exterior-colombia-2026'],
  'visa-estudiante-estados-unidos-colombia-2026':['estudiar-estados-unidos-colombia-2026','estudiar-ingles-nueva-york-colombia','diferencia-ielts-toefl-colombia','ingles-b2-cuanto-tiempo-colombia','maestrias-exterior-colombia-2026'],
  'nueva-york-vs-miami-colombia':['estudiar-estados-unidos-colombia-2026','estudiar-ingles-nueva-york-colombia','visa-estudiante-estados-unidos-colombia-2026','costo-estudiar-exterior-2026','mejor-pais-estudiar-ingles-colombia-2026'],
  'estudiar-ingles-nueva-york-colombia':['estudiar-estados-unidos-colombia-2026','nueva-york-vs-miami-colombia','visa-estudiante-estados-unidos-colombia-2026','alojamiento-estudiar-exterior-colombia','costo-estudiar-exterior-2026'],
  'estudiar-alemania-colombia-2026':['visa-estudiante-alemania-colombia-2026','estudiar-gratis-alemania-colombianos','maestrias-exterior-colombia-2026','visa-schengen-colombianos-2026','becas-estudiar-exterior-colombia-2026'],
  'visa-estudiante-alemania-colombia-2026':['estudiar-alemania-colombia-2026','estudiar-gratis-alemania-colombianos','maestrias-exterior-colombia-2026','visa-schengen-colombianos-2026','diferencia-visa-estudiante-working-holiday'],
  'estudiar-gratis-alemania-colombianos':['estudiar-alemania-colombia-2026','visa-estudiante-alemania-colombia-2026','maestrias-exterior-colombia-2026','becas-estudiar-exterior-colombia-2026','estudiar-exterior-sin-dinero-colombia-2026'],
  'estudiar-dubai-colombia-2026':['visa-estudiante-dubai-colombia-2026','costo-estudiar-exterior-2026','mejor-pais-estudiar-ingles-colombia-2026','alojamiento-estudiar-exterior-colombia','diferencia-visa-estudiante-working-holiday'],
  'visa-estudiante-dubai-colombia-2026':['estudiar-dubai-colombia-2026','diferencia-visa-estudiante-working-holiday','costo-estudiar-exterior-2026','requisitos-estudiar-exterior-colombia','alojamiento-estudiar-exterior-colombia'],
  'estudiar-francia-colombia-2026':['visa-estudiante-alemania-colombia-2026','visa-schengen-colombianos-2026','maestrias-exterior-colombia-2026','becas-estudiar-exterior-colombia-2026','costo-estudiar-exterior-2026'],
  'mejor-pais-estudiar-ingles-colombia-2026':['australia-vs-irlanda-colombianos-2026','australia-vs-canada-colombianos-2026','malta-vs-irlanda-colombianos-2026','canada-vs-reino-unido-colombianos-2026','costo-estudiar-exterior-2026'],
  'mejores-ciudades-estudiar-ingles-2026':['mejor-pais-estudiar-ingles-colombia-2026','sydney-vs-melbourne-colombia','dublin-vs-cork-colombia','toronto-vs-vancouver-colombia','londres-vs-manchester-colombia'],
  'costo-estudiar-exterior-2026':['como-financiar-estudios-exterior-colombia','estudiar-exterior-sin-dinero-colombia-2026','becas-estudiar-exterior-colombia-2026','trabajar-mientras-estudias-exterior','alojamiento-estudiar-exterior-colombia'],
  'como-financiar-estudios-exterior-colombia':['costo-estudiar-exterior-2026','estudiar-exterior-sin-dinero-colombia-2026','becas-estudiar-exterior-colombia-2026','trabajar-mientras-estudias-exterior','agencia-estudios-exterior-colombia'],
  'estudiar-exterior-sin-dinero-colombia-2026':['como-financiar-estudios-exterior-colombia','becas-estudiar-exterior-colombia-2026','costo-estudiar-exterior-2026','estudiar-gratis-alemania-colombianos','trabajar-mientras-estudias-exterior'],
  'becas-estudiar-exterior-colombia-2026':['estudiar-exterior-sin-dinero-colombia-2026','como-financiar-estudios-exterior-colombia','estudiar-gratis-alemania-colombianos','maestrias-exterior-colombia-2026','costo-estudiar-exterior-2026'],
  'trabajar-mientras-estudias-exterior':['cuanto-gana-colombiano-australia','como-conseguir-trabajo-extranjero-colombia','diferencia-visa-estudiante-working-holiday','working-holiday-visa-colombia','costo-estudiar-exterior-2026'],
  'como-conseguir-trabajo-extranjero-colombia':['trabajar-mientras-estudias-exterior','cuanto-gana-colombiano-australia','vivir-trabajar-irlanda-colombianos-2026','ingles-b2-cuanto-tiempo-colombia','diferencia-ielts-toefl-colombia'],
  'working-holiday-visa-colombia':['diferencia-visa-estudiante-working-holiday','visa-estudiante-australia-2026','visa-estudiante-nueva-zelanda-colombia-2026','requisitos-visa-trabajo-australia-colombia','trabajar-mientras-estudias-exterior'],
  'diferencia-visa-estudiante-working-holiday':['working-holiday-visa-colombia','visa-estudiante-australia-2026','visa-estudiante-irlanda-colombia-2026','visa-estudiante-canada-2026','trabajar-mientras-estudias-exterior'],
  'alojamiento-estudiar-exterior-colombia':['costo-estudiar-exterior-2026','como-financiar-estudios-exterior-colombia','estudiar-ingles-dublin-colombia','estudiar-ingles-sydney-colombia','estudiar-australia-colombia-2026'],
  'maestrias-exterior-colombia-2026':['universidades-canada-colombianos-sin-ielts','estudiar-gratis-alemania-colombianos','becas-estudiar-exterior-colombia-2026','diferencia-ielts-toefl-colombia','ingles-b2-cuanto-tiempo-colombia'],
  'diferencia-ielts-toefl-colombia':['ingles-b2-cuanto-tiempo-colombia','maestrias-exterior-colombia-2026','universidades-canada-colombianos-sin-ielts','como-elegir-escuela-idiomas-exterior','requisitos-estudiar-exterior-colombia'],
  'ingles-b2-cuanto-tiempo-colombia':['diferencia-ielts-toefl-colombia','como-elegir-escuela-idiomas-exterior','trabajar-mientras-estudias-exterior','requisitos-estudiar-exterior-colombia','estudiar-australia-colombia-2026'],
  'como-elegir-escuela-idiomas-exterior':['agencia-estudios-exterior-colombia','agencia-estudiar-exterior-colombia-como-elegir','diferencia-ielts-toefl-colombia','requisitos-estudiar-exterior-colombia','alojamiento-estudiar-exterior-colombia'],
  'agencia-estudios-exterior-colombia':['agencia-estudiar-exterior-colombia-como-elegir','como-elegir-escuela-idiomas-exterior','requisitos-estudiar-exterior-colombia','costo-estudiar-exterior-2026','como-financiar-estudios-exterior-colombia'],
  'agencia-estudiar-exterior-colombia-como-elegir':['agencia-estudios-exterior-colombia','como-elegir-escuela-idiomas-exterior','requisitos-estudiar-exterior-colombia','estudiar-australia-colombia-2026','estudiar-irlanda-colombia-2026'],
  'requisitos-estudiar-exterior-colombia':['agencia-estudios-exterior-colombia','como-elegir-escuela-idiomas-exterior','diferencia-ielts-toefl-colombia','costo-estudiar-exterior-2026','alojamiento-estudiar-exterior-colombia'],
};

var TITLES={
  'estudiar-australia-colombia-2026':'Estudiar en Australia 2026',
  'visa-estudiante-australia-2026':'Visa Estudiante Australia',
  'sydney-vs-melbourne-colombia':'Sydney vs Melbourne',
  'cuanto-gana-colombiano-australia':'Cuánto gana un colombiano en Australia',
  'requisitos-visa-trabajo-australia-colombia':'Requisitos Visa Trabajo Australia',
  'australia-vs-irlanda-colombianos-2026':'Australia vs Irlanda',
  'australia-vs-canada-colombianos-2026':'Australia vs Canadá',
  'vuelo-colombia-australia-precio-duracion-2026':'Vuelo Colombia → Australia',
  'estudiar-ingles-sydney-colombia':'Estudiar inglés en Sydney',
  'estudiar-ingles-melbourne-colombia':'Estudiar inglés en Melbourne',
  'estudiar-irlanda-colombia-2026':'Estudiar en Irlanda 2026',
  'visa-estudiante-irlanda-colombia-2026':'Visa Estudiante Irlanda',
  'dublin-vs-cork-colombia':'Dublín vs Cork',
  'estudiar-ingles-dublin-colombia':'Estudiar inglés en Dublín',
  'estudiar-ingles-cork-colombia':'Estudiar inglés en Cork',
  'vivir-trabajar-irlanda-colombianos-2026':'Vivir y trabajar en Irlanda',
  'emigrar-irlanda-colombia-proceso-completo':'Emigrar a Irlanda desde Colombia',
  'costo-estudiar-ingles-irlanda-mensualmente':'Costo estudiar inglés en Irlanda',
  'malta-vs-irlanda-colombianos-2026':'Malta vs Irlanda',
  'estudiar-malta-colombia-2026':'Estudiar en Malta 2026',
  'visa-estudiante-malta-colombia-2026':'Visa Estudiante Malta',
  'estudiar-ingles-malta-opiniones-colombianos':'Estudiar inglés en Malta',
  'visa-schengen-colombianos-2026':'Visa Schengen para colombianos',
  'estudiar-canada-colombia-2026':'Estudiar en Canadá 2026',
  'visa-estudiante-canada-2026':'Visa Estudiante Canadá',
  'toronto-vs-vancouver-colombia':'Toronto vs Vancouver',
  'estudiar-ingles-toronto-colombia':'Estudiar inglés en Toronto',
  'estudiar-ingles-vancouver-colombia':'Estudiar inglés en Vancouver',
  'vivir-estudiar-canada-colombianos':'Vivir y estudiar en Canadá',
  'universidades-canada-colombianos-sin-ielts':'Universidades en Canadá sin IELTS',
  'canada-vs-reino-unido-colombianos-2026':'Canadá vs Reino Unido',
  'estudiar-reino-unido-colombia-2026':'Estudiar en Reino Unido 2026',
  'visa-estudiante-reino-unido-colombia-2026':'Visa Estudiante Reino Unido',
  'londres-vs-manchester-colombia':'Londres vs Manchester',
  'estudiar-ingles-londres-colombia':'Estudiar inglés en Londres',
  'estudiar-ingles-manchester-colombia':'Estudiar inglés en Manchester',
  'estudiar-nueva-zelanda-colombia-2026':'Estudiar en Nueva Zelanda 2026',
  'visa-estudiante-nueva-zelanda-colombia-2026':'Visa Estudiante Nueva Zelanda',
  'estudiar-ingles-auckland-colombia':'Estudiar inglés en Auckland',
  'estudiar-estados-unidos-colombia-2026':'Estudiar en EE.UU. 2026',
  'visa-estudiante-estados-unidos-colombia-2026':'Visa Estudiante EE.UU.',
  'nueva-york-vs-miami-colombia':'Nueva York vs Miami',
  'estudiar-ingles-nueva-york-colombia':'Estudiar inglés en Nueva York',
  'estudiar-alemania-colombia-2026':'Estudiar en Alemania 2026',
  'visa-estudiante-alemania-colombia-2026':'Visa Estudiante Alemania',
  'estudiar-gratis-alemania-colombianos':'Estudiar gratis en Alemania',
  'estudiar-dubai-colombia-2026':'Estudiar en Dubai 2026',
  'visa-estudiante-dubai-colombia-2026':'Visa Estudiante Dubai',
  'estudiar-francia-colombia-2026':'Estudiar en Francia 2026',
  'mejor-pais-estudiar-ingles-colombia-2026':'Mejor país para estudiar inglés',
  'mejores-ciudades-estudiar-ingles-2026':'Mejores ciudades para estudiar inglés',
  'costo-estudiar-exterior-2026':'Costo de estudiar en el exterior 2026',
  'como-financiar-estudios-exterior-colombia':'Cómo financiar estudios en el exterior',
  'estudiar-exterior-sin-dinero-colombia-2026':'Estudiar en el exterior sin dinero',
  'becas-estudiar-exterior-colombia-2026':'Becas para estudiar en el exterior',
  'trabajar-mientras-estudias-exterior':'Trabajar mientras estudias en el exterior',
  'como-conseguir-trabajo-extranjero-colombia':'Cómo conseguir trabajo en el extranjero',
  'working-holiday-visa-colombia':'Working Holiday Visa para colombianos',
  'diferencia-visa-estudiante-working-holiday':'Visa estudiante vs Working Holiday',
  'alojamiento-estudiar-exterior-colombia':'Alojamiento para estudiar en el exterior',
  'maestrias-exterior-colombia-2026':'Maestrías en el exterior 2026',
  'diferencia-ielts-toefl-colombia':'IELTS vs TOEFL para colombianos',
  'ingles-b2-cuanto-tiempo-colombia':'¿Cuánto tiempo para llegar a B2?',
  'como-elegir-escuela-idiomas-exterior':'Cómo elegir escuela de idiomas',
  'agencia-estudios-exterior-colombia':'Agencia de estudios en el exterior',
  'agencia-estudiar-exterior-colombia-como-elegir':'Cómo elegir agencia para estudiar',
  'requisitos-estudiar-exterior-colombia':'Requisitos para estudiar en el exterior',
};

var ICONS={
  'australia':'🇦🇺','irlanda':'🇮🇪','canada':'🇨🇦','reino':'🇬🇧','malta':'🇲🇹','nueva-zelanda':'🇳🇿','estados-unidos':'🇺🇸','alemania':'🇩🇪','dubai':'🇦🇪','francia':'🇫🇷',
  'visa':'🛂','costo':'💰','trabajo':'💼','comparativa':'⚖️','ciudad':'🏙️','proceso':'📋'
};

function getSlug(){
  var path=window.location.pathname;
  var m=path.match(/\/blog\/([^\/]+?)(?:\.html)?(?:\/)?$/);
  return m?m[1]:null;
}

function getIcon(slug){
  for(var k in ICONS){if(slug.indexOf(k)>=0)return ICONS[k];}
  return '📖';
}

function render(){
  var slug=getSlug();
  if(!slug||!MAP[slug])return;
  var related=MAP[slug].slice(0,4);
  var html='<section style="max-width:800px;margin:50px auto 0;padding:0 20px 60px;">'
    +'<h2 style="color:#1B4B8C;font-size:1.5rem;margin-bottom:6px;padding-bottom:12px;border-bottom:3px solid #1ABC9C;">También te puede interesar</h2>'
    +'<div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(240px,1fr));gap:16px;margin-top:24px;">';
  related.forEach(function(r){
    var title=TITLES[r]||r.replace(/-/g,' ');
    var icon=getIcon(r);
    html+='<a href="/blog/'+r+'.html" style="display:block;background:#f8f9fa;border:1px solid #e0e0e0;border-radius:10px;padding:18px;text-decoration:none;color:#2C3E50;transition:border-color .2s;font-size:.95rem;" onmouseover="this.style.borderColor=\'#1ABC9C\'" onmouseout="this.style.borderColor=\'#e0e0e0\'">'
      +'<span style="font-size:1.4rem;display:block;margin-bottom:8px;">'+icon+'</span>'
      +'<span style="font-weight:600;line-height:1.4;display:block;">'+title+'</span>'
      +'</a>';
  });
  html+='</div>'
    +'<div style="text-align:center;margin-top:32px;">'
    +'<a href="/blog/" style="color:#1ABC9C;font-weight:600;text-decoration:none;font-size:.95rem;">← Ver todas las guías</a>'
    +'</div></section>';
  document.body.insertAdjacentHTML('beforeend',html);
}

if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',render);}else{render();}
})();
