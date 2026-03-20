/**
 * NAVIA GLOBAL — Lead Agent Connector
 * Intercepta el formulario de contacto y notifica al agente de calificacion
 * sin interferir con el envio normal a Formspree.
 */
(function() {
  function initLeadAgent() {
    const form = document.getElementById('contactForm');
    if (!form) return;

    form.addEventListener('submit', function(e) {
      // Recopilar datos del formulario
      const data = {};
      const fields = ['nombre', 'whatsapp', 'email', 'edad', 'destino', 'presupuesto', 'fecha_viaje', 'mensaje', 'consulta'];
      fields.forEach(function(field) {
        const el = form.querySelector('[name="' + field + '"]');
        if (el && el.value) data[field] = el.value;
      });

      // Llamar al agente en segundo plano (fire and forget)
      // No bloquea el submit normal a Formspree
      fetch('/api/qualify-lead', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
        keepalive: true
      }).catch(function() {
        // Silencioso - no afecta la experiencia del usuario
      });
    });
  }

  // Inicializar cuando el DOM esté listo
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initLeadAgent);
  } else {
    initLeadAgent();
  }
})();
