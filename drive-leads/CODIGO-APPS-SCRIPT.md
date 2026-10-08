# Receptor de leads en Drive

Código del Apps Script que recibe los formularios de naviaglobal.co y los
escribe en la hoja **Navia · Leads del sitio**.

Hoja: https://docs.google.com/spreadsheets/d/18k3jLwaxoP13mSyE_EFe_j0oIBdM8hb46MKDpytUPC8/edit

## Instalación

1. Abre la hoja
2. **Extensiones → Apps Script**
3. Borra todo lo que haya y pega el código de abajo
4. **Implementar → Nueva implementación → Aplicación web**
   - Ejecutar como: **Yo**
   - Quién tiene acceso: **Cualquier usuario**
5. Copia la URL que termina en `/exec`

Antes de publicar puedes correr la función `probar()` desde el editor: debe
aparecer una fila en una pestaña llamada `prueba` y llegarte el correo.

Este archivo queda fuera del sitio publicado: el despliegue excluye los `.md`.

## Código

```javascript
/**
 * Navia · Receptor de leads del sitio
 * --------------------------------------------------------------------------
 * Recibe los formularios de naviaglobal.co y los escribe en esta hoja, una
 * pestaña por origen. Reemplaza a Formspree, que en su plan gratis topa en
 * 50 envíos al mes y borra el histórico a los 30 días.
 *
 * Hace tres cosas por cada lead:
 *   1. Lo guarda en la pestaña que le corresponde, creando columnas nuevas
 *      sola si el formulario manda un campo que no existía.
 *   2. Te avisa por correo.
 *   3. Le responde al lead confirmándole que llegó.
 *
 * CÓMO SE INSTALA
 *   1. Abre la hoja "Navia · Leads del sitio"
 *   2. Extensiones → Apps Script
 *   3. Borra lo que haya y pega este archivo completo
 *   4. Implementar → Nueva implementación → tipo "Aplicación web"
 *        · Ejecutar como: Yo
 *        · Quién tiene acceso: Cualquier usuario
 *   5. Copia la URL que termina en /exec y pásasela a Claude
 *
 * Cada vez que cambies el código hay que crear una implementación NUEVA
 * (o editar la existente y subir la versión), o la URL sigue sirviendo lo viejo.
 */

// A dónde llegan los avisos.
//
// OJO: si pones una dirección de ESTA MISMA cuenta (incluidos sus alias, como
// info@naviaglobal.co), Gmail no te la entrega en Recibidos: la archiva solo en
// Enviados. Para que te llegue a la bandeja, usa un correo distinto —uno
// personal de Gmail, por ejemplo— o revisa Enviados.
var AVISAR_A = 'info@naviaglobal.co';

// Responderle al lead confirmando que recibimos sus datos.
var RESPONDER_AL_LEAD = true;

// Campos que nunca se guardan: los de control de Formspree y la trampa de spam.
var IGNORAR = ['_subject', '_cc', '_next', '_redirect', '_gotcha', '_replyto', 'website_url'];


function doPost(e) {
  try {
    var datos = leerDatos(e);

    // Trampa de spam: es un campo oculto que una persona nunca llena.
    if (datos['website_url']) return respuesta({ ok: true, ignorado: 'spam' });

    var pestana = nombrePestana(datos);
    guardar(pestana, datos);
    avisar(pestana, datos);
    if (RESPONDER_AL_LEAD) responder(datos);

    return respuesta({ ok: true, pestana: pestana });
  } catch (err) {
    // Se registra para poder revisarlo, pero se devuelve ok para no dejar al
    // usuario con un error en pantalla cuando el lead quizá sí se guardó.
    try {
      registrarFallo(err, e);
    } catch (e2) {}
    return respuesta({ ok: false, error: String(err) });
  }
}

function doGet() {
  return respuesta({ ok: true, servicio: 'Navia · receptor de leads' });
}


/* ---------------------------------------------------------------- lectura */

function leerDatos(e) {
  var d = {};
  // Formulario clásico (FormData)
  if (e && e.parameter) {
    for (var k in e.parameter) d[k] = e.parameter[k];
  }
  // JSON mandado como texto plano (así no dispara preflight de CORS)
  if (e && e.postData && e.postData.contents) {
    try {
      var j = JSON.parse(e.postData.contents);
      if (j && typeof j === 'object') for (var k2 in j) d[k2] = j[k2];
    } catch (err) {}
  }
  for (var i = 0; i < IGNORAR.length; i++) delete d[IGNORAR[i]];
  return d;
}

function nombrePestana(d) {
  var o = (d.origen || d.fuente || '').toString().trim().toLowerCase();
  if (o.indexOf('cuantoafuera') > -1) return 'cuantoafuera';
  if (o) return o.replace(/[^a-z0-9\- ]/g, '').substring(0, 28) || 'sitio';
  if (d.destino) return 'destinos';
  return 'sitio';
}


/* --------------------------------------------------------------- escritura */

function guardar(nombre, datos) {
  var ss = SpreadsheetApp.getActive();
  var h = ss.getSheetByName(nombre);
  if (!h) {
    h = ss.insertSheet(nombre);
    h.appendRow(['fecha']);
    h.getRange(1, 1, 1, 1).setFontWeight('bold');
    h.setFrozenRows(1);
  }

  var ultima = Math.max(1, h.getLastColumn());
  var cabeceras = h.getRange(1, 1, 1, ultima).getValues()[0];
  if (!cabeceras[0]) { cabeceras = ['fecha']; h.getRange(1, 1).setValue('fecha'); }

  // Columnas nuevas para campos que no habíamos visto antes
  var nuevas = [];
  for (var k in datos) if (cabeceras.indexOf(k) === -1) nuevas.push(k);
  if (nuevas.length) {
    h.getRange(1, cabeceras.length + 1, 1, nuevas.length).setValues([nuevas]).setFontWeight('bold');
    cabeceras = cabeceras.concat(nuevas);
  }

  var fila = [];
  for (var i = 0; i < cabeceras.length; i++) {
    var c = cabeceras[i];
    fila.push(c === 'fecha' ? new Date() : texto(datos[c]));
  }
  h.appendRow(fila);
  h.autoResizeColumns(1, Math.min(cabeceras.length, 12));
}

/**
 * Sheets interpreta como formula cualquier celda que empiece por + = - @, y un
 * WhatsApp "+57 300..." se guardaba como #ERROR!, perdiendo el dato mas
 * importante del lead. El apostrofe fuerza texto y no se ve en la celda.
 */
function texto(v) {
  if (v === undefined || v === null) return '';
  var s = String(v);
  return /^[=+\-@]/.test(s) ? "'" + s : s;
}


/* ------------------------------------------------------------------ avisos */

function avisar(pestana, d) {
  var para = AVISAR_A || Session.getEffectiveUser().getEmail();
  if (!para) return;

  var score = d.lead_score ? ' [' + d.lead_score + ']' : '';
  var asunto = 'Lead' + score + ' · ' + (d.destino || pestana) + ' · ' + (d.nombre || 'sin nombre');

  var l = [];
  l.push('Origen: ' + pestana);
  if (d.nombre) l.push('Nombre: ' + d.nombre);
  if (d.whatsapp) l.push('WhatsApp: ' + d.whatsapp);
  var correo = d.correo || d.email;
  if (correo) l.push('Correo: ' + correo);
  if (d.destino) l.push('Destino: ' + d.destino);
  if (d.programa) l.push('Programa: ' + d.programa);
  if (d.fecha_proyectada_viaje) l.push('Viaja: ' + d.fecha_proyectada_viaje +
      (d.meses_hasta_el_viaje !== undefined ? ' (en ' + d.meses_hasta_el_viaje + ' meses)' : ''));
  if (d.costo_total_cop) l.push('Costo calculado: $' + Number(d.costo_total_cop).toLocaleString('es-CO') + ' COP');
  if (d.fondos_requeridos_cop) l.push('Fondos que necesita: $' + Number(d.fondos_requeridos_cop).toLocaleString('es-CO') + ' COP');
  if (d.ahorro_disponible) l.push('Ahorro: ' + d.ahorro_disponible);
  if (d.quien_financia) l.push('Financia: ' + d.quien_financia);
  if (d.nivel_ingles) l.push('Inglés: ' + d.nivel_ingles);
  if (d.mensaje) l.push('\nMensaje:\n' + d.mensaje);

  // Lo que no quedó listado arriba, para no perder nada
  var listados = ['origen','fuente','nombre','whatsapp','correo','email','destino','programa',
                  'fecha_proyectada_viaje','meses_hasta_el_viaje','costo_total_cop',
                  'fondos_requeridos_cop','ahorro_disponible','quien_financia','nivel_ingles',
                  'mensaje','lead_score'];
  var otros = [];
  for (var k in d) if (listados.indexOf(k) === -1) otros.push(k + ': ' + d[k]);
  if (otros.length) l.push('\nOtros datos:\n' + otros.join('\n'));

  if (d.whatsapp) {
    var tel = String(d.whatsapp).replace(/\D/g, '');
    l.push('\nEscribirle: https://wa.me/' + tel);
  }
  l.push('\nHoja: ' + SpreadsheetApp.getActive().getUrl());

  MailApp.sendEmail(para, asunto, l.join('\n'));
}

function responder(d) {
  var correo = d.correo || d.email;
  if (!correo || correo.indexOf('@') === -1) return;
  var nombre = (d.nombre || '').split(' ')[0];

  var cuerpo = [
    (nombre ? 'Hola ' + nombre + ',' : 'Hola,'),
    '',
    'Recibimos tus datos. Samuel, el fundador de Navia, revisa tu caso y te escribe',
    'por WhatsApp en las próximas horas hábiles.',
    '',
    (d.destino ? 'Destino que consultaste: ' + d.destino : ''),
    (d.costo_total_cop ? 'Costo total estimado: $' + Number(d.costo_total_cop).toLocaleString('es-CO') + ' COP' : ''),
    (d.fondos_requeridos_cop ? 'Fondos que exige la visa: $' + Number(d.fondos_requeridos_cop).toLocaleString('es-CO') + ' COP' : ''),
    '',
    'Ten en cuenta que esas cifras son una estimación: la matrícula y el costo de vida',
    'cambian según la escuela, la ciudad y la duración. Los montos de fondos de visa y',
    'las horas de trabajo sí salen de las páginas oficiales de inmigración.',
    '',
    'Si quieres adelantar, escríbenos directo: https://wa.me/573014430722',
    '',
    '— Navia Global Education S.A.S.',
    'Tu puente al mundo. · naviaglobal.co',
    '',
    'Recibes este correo porque pediste información en naviaglobal.co.',
    'Si no fuiste tú, responde a este mensaje y eliminamos tus datos.'
  ].filter(function (x) { return x !== ''; }).join('\n');

  MailApp.sendEmail({
    to: correo,
    subject: 'Recibimos tus datos · Navia Global',
    body: cuerpo,
    name: 'Navia Global Education',
    replyTo: AVISAR_A || undefined
  });
}


/* ------------------------------------------------------------------- varios */

function registrarFallo(err, e) {
  var ss = SpreadsheetApp.getActive();
  var h = ss.getSheetByName('_errores') || ss.insertSheet('_errores');
  if (h.getLastRow() === 0) h.appendRow(['fecha', 'error', 'datos recibidos']);
  var crudo = '';
  try { crudo = e && e.postData ? e.postData.contents : JSON.stringify(e && e.parameter); } catch (x) {}
  h.appendRow([new Date(), String(err), String(crudo).substring(0, 4000)]);
}

function respuesta(obj) {
  return ContentService.createTextOutput(JSON.stringify(obj))
    .setMimeType(ContentService.MimeType.JSON);
}

/** Pruébalo desde el editor antes de publicar: debe aparecer una fila en la
 *  pestaña "prueba" y llegarte el correo de aviso. */
function probar() {
  doPost({
    parameter: {},
    postData: {
      contents: JSON.stringify({
        origen: 'prueba',
        nombre: 'Prueba Local',
        correo: AVISAR_A,
        whatsapp: '+57 3001112233',
        destino: 'Canadá',
        programa: 'college/técnico',
        costo_total_cop: 112670206,
        fondos_requeridos_cop: 94086960,
        lead_score: 'B'
      })
    }
  });
}

```
