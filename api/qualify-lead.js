/**
 * NAVIA GLOBAL — Agente de Calificación de Leads
 * Vercel Serverless Function (Node.js 22.x)
 *
 * Flujo:
 *  1. Recibe webhook de Formspree con datos del formulario
 *  2. Llama a Claude API para calificar el lead y generar mensaje personalizado
 *  3. Envía alerta WhatsApp a Samuel via WhatsApp Cloud API (Meta)
 *  4. Devuelve 200 OK
 *
 * Variables de entorno requeridas en Vercel:
 *  ANTHROPIC_API_KEY       — API key de Anthropic
 *  WHATSAPP_TOKEN          — Token de acceso de WhatsApp Cloud API (Meta)
 *  WHATSAPP_PHONE_ID       — Phone Number ID de tu número verificado en Meta
 *  NAVIA_WHATSAPP_NUMBER   — Tu número (ej: 573014430722)
 *  FORMSPREE_SECRET        — Secret para verificar el webhook de Formspree (opcional)
 */

export const config = { runtime: 'nodejs' };

const DESTINOS_INFO = {
  australia: { nombre: 'Australia', emoji: '🇦🇺', visa: 'Subclass 500', precio_base: 'desde USD 3,500', beneficio_clave: 'trabajo 48h/quincena + pathway a PR' },
  canada: { nombre: 'Canadá', emoji: '🇨🇦', visa: 'Study Permit', precio_base: 'desde USD 4,200', beneficio_clave: 'trabajo part-time ilimitado + residencia permanente' },
  irlanda: { nombre: 'Irlanda', emoji: '🇮🇪', visa: 'Stamp 2', precio_base: '25 semanas desde €2,700 todo incluido', beneficio_clave: 'inglés en zona euro + trabajo 20h/semana' },
  malta: { nombre: 'Malta', emoji: '🇲🇹', visa: 'Student Visa', precio_base: 'desde €1,800', beneficio_clave: 'el más económico de Europa + inglés oficial' },
  dubai: { nombre: 'Dubai', emoji: '🇦🇪', visa: 'Student Visa UAE', precio_base: 'desde USD 2,800', beneficio_clave: 'sin impuestos + inglés en hub global de negocios' },
  'nueva zelanda': { nombre: 'Nueva Zelanda', emoji: '🇳🇿', visa: 'Student Visa NZ', precio_base: 'desde NZD 4,000', beneficio_clave: 'calidad de vida top + trabajo 20h/semana' },
  'reino unido': { nombre: 'Reino Unido', emoji: '🇬🇧', visa: 'Student Visa UK', precio_base: 'desde GBP 3,800', beneficio_clave: 'inglés británico + 20h/semana de trabajo' },
  usa: { nombre: 'Estados Unidos', emoji: '🇺🇸', visa: 'F-1', precio_base: 'desde USD 5,000', beneficio_clave: 'inglés americano + networking global' },
  alemania: { nombre: 'Alemania', emoji: '🇩🇪', visa: 'Student Visa', precio_base: 'desde €2,200', beneficio_clave: 'alemán + mercado laboral europeo' },
  francia: { nombre: 'Francia', emoji: '🇫🇷', visa: 'Student Visa', precio_base: 'desde €2,400', beneficio_clave: 'francés + cultura europea + inglés' },
};

export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const body = req.body;
    const lead = extractLeadData(body);
    console.log('[Navia Lead]', JSON.stringify(lead));

    const calificacion = await calificarConClaude(lead);
    console.log('[Calificacion]', JSON.stringify(calificacion));

    await enviarWhatsApp(lead, calificacion);

    return res.status(200).json({ ok: true, etapa: calificacion.etapa, destino: calificacion.destino_detectado });
  } catch (err) {
    console.error('[Error qualify-lead]', err);
    return res.status(500).json({ error: err.message });
  }
}

function extractLeadData(body) {
  return {
    nombre: body.nombre || body.name || body['tu-nombre'] || 'Sin nombre',
    email: body.email || body.correo || '',
    telefono: body.telefono || body.phone || body.whatsapp || '',
    destino: body.destino || body['pais-interes'] || '',
    mensaje: body.mensaje || body.message || body.consulta || '',
    edad: body.edad || '',
    presupuesto: body.presupuesto || '',
    fecha_viaje: body.fecha_viaje || body.cuando || '',
    _referrer: body._referrer || '',
    timestamp: new Date().toISOString(),
  };
}

async function calificarConClaude(lead) {
  const prompt = `Eres el asistente de calificación de leads de Navia Global Education, agencia colombiana de estudios en el exterior. 8 años de experiencia, 500+ estudiantes, 95% aprobación de visas. Destinos: Australia, Canadá, Irlanda, Malta, Dubai, Nueva Zelanda, Reino Unido, USA, Alemania, Francia.

Lead recibido:
- Nombre: ${lead.nombre}
- Destino de interés: ${lead.destino || 'No especificado'}
- Mensaje: ${lead.mensaje || 'Sin mensaje'}
- Presupuesto: ${lead.presupuesto || 'No especificado'}
- Fecha de viaje: ${lead.fecha_viaje || 'No especificada'}
- Teléfono: ${lead.telefono || 'No dado'}

Tareas:
1. Detectar destino principal (australia/canada/irlanda/malta/dubai/nueva zelanda/reino unido/usa/alemania/francia). Si no se menciona, sugerir el mejor según perfil.
2. Clasificar etapa:
   - "listo": fecha + presupuesto + destino claros → reunión urgente
   - "explorando": destino claro pero sin fecha/presupuesto → seguimiento activo
   - "temprano": solo averiguando → nutrir con info
3. Generar mensaje WhatsApp para enviar AL LEAD (máx 160 palabras), cálido, de parte de Samuel de Navia Global. Incluir nombre del lead, destino, 1 beneficio clave, CTA clara.
4. Prioridad de seguimiento (alta/media/baja).

Responde SOLO JSON sin backticks:
{
  "destino_detectado": "...",
  "etapa": "listo|explorando|temprano",
  "prioridad": "alta|media|baja",
  "razon_calificacion": "1 línea",
  "mensaje_whatsapp": "mensaje completo para el lead",
  "proxima_accion": "qué hacer en las próximas horas"
}`;

  const r = await fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': process.env.ANTHROPIC_API_KEY,
      'anthropic-version': '2023-06-01',
    },
    body: JSON.stringify({
      model: 'claude-haiku-4-5-20251001',
      max_tokens: 1024,
      messages: [{ role: 'user', content: prompt }],
    }),
  });

  if (!r.ok) throw new Error(`Claude API ${r.status}: ${await r.text()}`);
  const data = await r.json();
  const raw = data.content[0]?.text || '{}';
  const parsed = JSON.parse(raw.replace(/```json|```/g, '').trim());
  const key = parsed.destino_detectado?.toLowerCase();
  parsed.info_destino = DESTINOS_INFO[key] || null;
  return parsed;
}

async function enviarWhatsApp(lead, cal) {
  const phoneNumberId = process.env.WHATSAPP_PHONE_ID;
  const token = process.env.WHATSAPP_TOKEN;
  const numeroNavia = process.env.NAVIA_WHATSAPP_NUMBER || '573014430722';

  if (!phoneNumberId || !token) {
    console.warn('[WhatsApp] Variables de entorno no configuradas — omitiendo envío');
    return { skipped: true };
  }

  const prioEmoji = { alta: '🔴', media: '🟡', baja: '🟢' }[cal.prioridad] || '⚪';
  const destinoNombre = cal.info_destino?.nombre || cal.destino_detectado || 'Por definir';
  const destinoEmoji = cal.info_destino?.emoji || '🌍';

  const alertaAsesor = `${prioEmoji} *NUEVO LEAD ${(cal.prioridad || '').toUpperCase()}* — Navia Global

👤 *${lead.nombre}*
📱 ${lead.telefono || 'Sin teléfono'}
📧 ${lead.email}
${destinoEmoji} Destino: *${destinoNombre}*
📊 Etapa: *${cal.etapa}*
💬 "${lead.mensaje || 'Sin mensaje'}"

_${cal.razon_calificacion}_

✅ *Próxima acción:* ${cal.proxima_accion}

───────────────────
*Mensaje sugerido para enviarle:*

${cal.mensaje_whatsapp}`;

  const response = await fetch(
    `https://graph.facebook.com/v19.0/${phoneNumberId}/messages`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        messaging_product: 'whatsapp',
        to: numeroNavia,
        type: 'text',
        text: { body: alertaAsesor },
      }),
    }
  );

  if (!response.ok) throw new Error(`WhatsApp ${response.status}: ${await response.text()}`);
  return response.json();
}
