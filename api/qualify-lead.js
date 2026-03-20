/**
 * NAVIA GLOBAL — Agente de Calificación de Leads
 * Vercel Serverless Function (Node.js 22.x)
 *
 * Flujo:
 *  1. Recibe webhook de Formspree con datos del formulario
 *  2. Llama a Claude API para calificar el lead
 *  3. Envía alerta por email a samuel.sanchez@naviaglobal.co via Resend
 *
 * Variables de entorno requeridas en Vercel:
 *  ANTHROPIC_API_KEY   — API key de Anthropic (ya configurada)
 *  RESEND_API_KEY      — API key de Resend (gratis en resend.com)
 */

export const config = { runtime: 'nodejs' };

const DESTINOS_INFO = {
  australia: { nombre: 'Australia', emoji: '🇦🇺', precio_base: 'desde USD 3,500', beneficio_clave: 'trabajo 48h/quincena + pathway a PR' },
  canada: { nombre: 'Canadá', emoji: '🇨🇦', precio_base: 'desde USD 4,200', beneficio_clave: 'trabajo part-time ilimitado + residencia permanente' },
  irlanda: { nombre: 'Irlanda', emoji: '🇮🇪', precio_base: '25 semanas desde €2,700 todo incluido', beneficio_clave: 'inglés en zona euro + trabajo 20h/semana' },
  malta: { nombre: 'Malta', emoji: '🇲🇹', precio_base: 'desde €1,800', beneficio_clave: 'el más económico de Europa + inglés oficial' },
  dubai: { nombre: 'Dubai', emoji: '🇦🇪', precio_base: 'desde USD 2,800', beneficio_clave: 'sin impuestos + inglés en hub global de negocios' },
  'nueva zelanda': { nombre: 'Nueva Zelanda', emoji: '🇳🇿', precio_base: 'desde NZD 4,000', beneficio_clave: 'calidad de vida top + trabajo 20h/semana' },
  'reino unido': { nombre: 'Reino Unido', emoji: '🇬🇧', precio_base: 'desde GBP 3,800', beneficio_clave: 'inglés británico + 20h/semana de trabajo' },
  usa: { nombre: 'Estados Unidos', emoji: '🇺🇸', precio_base: 'desde USD 5,000', beneficio_clave: 'inglés americano + networking global' },
  alemania: { nombre: 'Alemania', emoji: '🇩🇪', precio_base: 'desde €2,200', beneficio_clave: 'alemán + mercado laboral europeo' },
  francia: { nombre: 'Francia', emoji: '🇫🇷', precio_base: 'desde €2,400', beneficio_clave: 'francés + cultura europea + inglés' },
};

const NAVIA_EMAIL = 'samuel.sanchez@naviaglobal.co';

export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const lead = extractLeadData(req.body);
    console.log('[Navia Lead]', JSON.stringify(lead));

    const cal = await calificarConClaude(lead);
    console.log('[Calificacion]', JSON.stringify(cal));

    await enviarEmail(lead, cal);

    return res.status(200).json({ ok: true, etapa: cal.etapa, destino: cal.destino_detectado });
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
  const prompt = `Eres el asistente de calificación de leads de Navia Global Education, agencia colombiana de estudios en el exterior. 8 años de experiencia, 500+ estudiantes, 95% aprobación de visas.\n\nLead:\n- Nombre: ${lead.nombre}\n- Destino: ${lead.destino || 'No especificado'}\n- Mensaje: ${lead.mensaje || 'Sin mensaje'}\n- Presupuesto: ${lead.presupuesto || 'No especificado'}\n- Fecha viaje: ${lead.fecha_viaje || 'No especificada'}\n- Teléfono: ${lead.telefono || 'No dado'}\n\nResponde SOLO JSON sin backticks:\n{\n  "destino_detectado": "australia|canada|irlanda|malta|dubai|nueva zelanda|reino unido|usa|alemania|francia",\n  "etapa": "listo|explorando|temprano",\n  "prioridad": "alta|media|baja",\n  "razon_calificacion": "1 linea",\n  "mensaje_whatsapp": "mensaje calido para el lead max 160 palabras de parte de Samuel Navia Global",\n  "proxima_accion": "que hacer en proximas horas"\n}`;

  const r = await fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'x-api-key': process.env.ANTHROPIC_API_KEY, 'anthropic-version': '2023-06-01' },
    body: JSON.stringify({ model: 'claude-haiku-4-5-20251001', max_tokens: 1024, messages: [{ role: 'user', content: prompt }] }),
  });

  if (!r.ok) throw new Error(`Claude API ${r.status}: ${await r.text()}`);
  const data = await r.json();
  const parsed = JSON.parse(data.content[0]?.text.replace(/```json|```/g, '').trim() || '{}');
  parsed.info_destino = DESTINOS_INFO[parsed.destino_detectado?.toLowerCase()] || null;
  return parsed;
}

async function enviarEmail(lead, cal) {
  const resendKey = process.env.RESEND_API_KEY;
  if (!resendKey) { console.warn('[Email] RESEND_API_KEY no configurada'); return { skipped: true }; }

  const prioColor = { alta: '#E8314A', media: '#F5A623', baja: '#00D9A3' }[cal.prioridad] || '#888';
  const prioEmoji = { alta: '🔴', media: '🟡', baja: '🟢' }[cal.prioridad] || '⚪';
  const destino = cal.info_destino?.nombre || cal.destino_detectado || 'Por definir';
  const destinoEmoji = cal.info_destino?.emoji || '🌍';
  const waLink = lead.telefono ? `<div style="text-align:center;margin:24px 0"><a href="https://wa.me/57${lead.telefono.replace(/\D/g,'')}" style="background:#25D366;color:white;padding:14px 32px;border-radius:30px;text-decoration:none;font-weight:700;font-size:15px;display:inline-block">📱 Contactar por WhatsApp</a></div>` : '';

  const html = `<!DOCTYPE html><html><head><meta charset="UTF-8"></head><body style="margin:0;padding:0;background:#f5f5f5;font-family:Arial,sans-serif"><table width="100%" cellpadding="0" cellspacing="0" style="padding:30px 0"><tr><td align="center"><table width="600" cellpadding="0" cellspacing="0" style="background:white;border-radius:12px;overflow:hidden"><tr><td style="background:linear-gradient(135deg,#0B2C4A,#0B5F8C);padding:28px 32px"><table width="100%"><tr><td><span style="color:white;font-size:22px;font-weight:700">Navia Global</span><br><span style="color:#00D9A3;font-size:13px">Agente de Calificación de Leads</span></td><td align="right"><span style="background:${prioColor};color:white;padding:6px 16px;border-radius:20px;font-size:13px;font-weight:600">${prioEmoji} ${(cal.prioridad||'').toUpperCase()}</span></td></tr></table></td></tr><tr><td style="padding:28px 32px"><h2 style="margin:0 0 20px;color:#0B2C4A">👤 ${lead.nombre}</h2><table width="100%" style="border-collapse:collapse"><tr><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;color:#666;width:130px">📱 Teléfono</td><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;font-weight:600">${lead.telefono||'—'}</td></tr><tr><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;color:#666">📧 Email</td><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;font-weight:600">${lead.email||'—'}</td></tr><tr><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;color:#666">${destinoEmoji} Destino</td><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;font-weight:600;color:#0B5F8C">${destino}</td></tr><tr><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;color:#666">📊 Etapa</td><td style="padding:8px 0;border-bottom:1px solid #f0f0f0;font-weight:600">${cal.etapa}</td></tr></table>${lead.mensaje?`<div style="background:#f8f9fa;border-left:4px solid #0B5F8C;padding:16px;margin:20px 0;border-radius:0 8px 8px 0"><p style="margin:0;color:#444;font-style:italic">"${lead.mensaje}"</p></div>`:''}<div style="background:#EBF5FB;border-radius:8px;padding:20px;margin:20px 0"><h3 style="margin:0 0 10px;color:#0B2C4A;font-size:15px">🤖 Análisis</h3><p style="margin:0 0 6px;color:#444;font-size:14px"><b>Razón:</b> ${cal.razon_calificacion}</p><p style="margin:0;color:#444;font-size:14px"><b>Acción:</b> ${cal.proxima_accion}</p></div><div style="background:#F0FDF4;border:1px solid #00D9A3;border-radius:8px;padding:20px;margin:20px 0"><h3 style="margin:0 0 12px;color:#0B2C4A;font-size:15px">💬 Mensaje sugerido para el lead</h3><p style="margin:0;color:#333;font-size:14px;line-height:1.7;white-space:pre-wrap">${cal.mensaje_whatsapp}</p></div>${waLink}</td></tr><tr><td style="background:#f8f9fa;padding:14px 32px;border-top:1px solid #f0f0f0"><p style="margin:0;color:#999;font-size:11px;text-align:center">Navia Global · naviaglobal.co · ${new Date(lead.timestamp).toLocaleString('es-CO',{timeZone:'America/Bogota'})}</p></td></tr></table></td></tr></table></body></html>`;

  const r = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${resendKey}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ from: 'Navia Lead Agent <leads@naviaglobal.co>', to: [NAVIA_EMAIL], subject: `${prioEmoji} Lead ${(cal.prioridad||'').toUpperCase()} — ${lead.nombre} · ${destino}`, html }),
  });

  if (!r.ok) throw new Error(`Resend ${r.status}: ${await r.text()}`);
  return r.json();
}
