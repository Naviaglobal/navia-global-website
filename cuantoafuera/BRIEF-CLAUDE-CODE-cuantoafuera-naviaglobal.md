# Brief para Claude Code: integrar CuántoAfuera en naviaglobal.co

**Dueño:** Samuel Sánchez, Navia Global Education S.A.S. (NIT 902.003.125-8)
**Fecha del brief:** 7 de octubre de 2026
**Objetivo:** publicar la calculadora CuántoAfuera dentro de naviaglobal.co como herramienta + hub de contenido con SEO propio, que genere **leads calificados** para la asesoría de Navia.

---

## 0. Antes de escribir código

1. **Inspecciona el repo de naviaglobal.co** (GitHub, desplegado en Vercel). Hasta donde sé es un sitio de HTML estático con 8 artículos de blog. Confirma la estructura real (framework, carpetas, cómo se generan header/footer, si existe `sitemap.xml`, `robots.txt`, `vercel.json`) antes de proponer cambios.
2. **Revisa el plan de Vercel.** El plan Hobby no permite uso comercial. Si el proyecto está en Hobby, avísame antes de lanzar; no lo cambies tú.
3. **No borres ni renombres** URLs existentes. Si alguna ruta cambia, crea redirect 301 en `vercel.json`.
4. Trabaja en una rama (`feat/cuantoafuera`) y abre un PR. No hagas deploy a producción sin mi aprobación.
5. Al final, entrégame un resumen de qué cambiaste, qué quedó pendiente y cómo probarlo.

### Archivos de entrada (te los paso en `cuantoafuera-sitio.zip`)

| Archivo | Qué es |
|---|---|
| `cuantoafuera/index.html` | Calculadora funcional (HTML + CSS + JS vanilla, sin dependencias) |
| `cuantoafuera/privacidad.html` | Política de datos Ley 1581 (tiene campos `[ENTRE CORCHETES]` por completar) |
| `cuantoafuera/terminos.html` | Términos de uso (mismos campos pendientes) |
| `cuantoafuera/reporte/generar_reporte.py` | Generador del reporte PDF de pago (ReportLab) |

---

## 1. Decisiones de arquitectura (ya tomadas)

- **La herramienta vive en una subcarpeta:** `https://naviaglobal.co/cuantoafuera/`. No usar subdominio: la subcarpeta hereda la autoridad del dominio.
- **Marca:** "CuántoAfuera, una herramienta de Navia Global Education". La herramienta tiene nombre propio, pero usa la identidad visual de Navia.
- **Si se compra `cuantoafuera.com`:** solo redirect 301 a `naviaglobal.co/cuantoafuera/`. Nunca contenido duplicado.
- **Fuente única de datos:** todas las cifras (fondos, tarifas de visa, horas de trabajo, salarios mínimos, tasas de cambio) salen de **un solo archivo** `/cuantoafuera/data/requisitos.json`. La calculadora, las páginas por país y el generador del PDF leen de ahí. Así, cuando un gobierno cambie una cifra, se actualiza en un solo lugar.

### Estructura de URLs

```
/cuantoafuera/                                  → calculadora (página pilar)
/cuantoafuera/canada/                           → costo de estudiar en Canadá desde Colombia
/cuantoafuera/reino-unido/
/cuantoafuera/irlanda/
/cuantoafuera/australia/
/cuantoafuera/nueva-zelanda/
/cuantoafuera/canada/college/                   → país × tipo de programa (fase 2)
/cuantoafuera/canada/ingles/  …                 → 5 países × 4 tipos = 20 páginas
/cuantoafuera/prueba-de-fondos/                 → guía pilar de prueba de fondos
/cuantoafuera/trabajar-mientras-estudias/       → comparativo de permisos de trabajo
/cuantoafuera/cambios/                          → registro público de cambios de requisitos (con fechas)
/cuantoafuera/privacidad/  /cuantoafuera/terminos/
/blog/…                                         → artículos (ver sección 5), enlazan a la calculadora
```

Fase 3: agregar Malta, Alemania y Francia (son destinos activos de Navia; Malta es Tier 1).

---

## 2. Integración técnica

### 2.1 Identidad visual
Reemplaza la paleta y fuentes del prototipo por las de Navia, manteniendo modo claro/oscuro:

| Token | Valor |
|---|---|
| Azul Navia (primario) | `#1B4B8C` |
| Turquesa (acento, CTA) | `#32B298` |
| Azul claro | `#3996D3` |
| Gris oscuro (texto) | `#2C3E50` |
| Tipografía principal | Poppins |
| Tipografía secundaria | Montserrat |
| Tagline | "Tu puente al mundo." |

Usa el header y el footer existentes de naviaglobal.co en todas las páginas nuevas.

### 2.2 Captura de leads (lo más importante)

El formulario actual solo pide correo. Cámbialo por un **formulario en dos pasos**:

- **Paso 1 (bajo el resultado):** correo + autorización Ley 1581 → envía el presupuesto por correo.
- **Paso 2 (opcional, en la página de gracias):** "¿Quieres que un asesor revise tu caso gratis?" con estos campos:

| Campo | Tipo | Para qué sirve |
|---|---|---|
| Nombre | texto | — |
| WhatsApp | teléfono, con +57 por defecto | contacto |
| Destino y tipo de programa | se precargan desde la calculadora | calificación |
| ¿Cuándo quieres empezar? | menos de 6 meses / 6–12 meses / más de 12 meses / no sé | urgencia |
| ¿Cuánto tienes ahorrado o disponible? | rangos en COP | capacidad |
| ¿Quién financia? | yo / mis padres / crédito / beca / no sé | capacidad |
| Nivel de inglés | básico / intermedio / avanzado / tengo certificado | elegibilidad |
| Costo total calculado y fondos requeridos | ocultos, se envían automáticamente | contexto para el asesor |

**Destino de los datos:** hoy el sitio usa Formspree (`xdkpereb`). Úsalo para no agregar dependencias, con un formulario aparte para CuántoAfuera. Si se puede, envía también el lead a Edvisor.io (CRM de Navia); si no hay API disponible, déjalo documentado como pendiente.

**Calificación automática** (calcula un campo `lead_score` antes de enviar):

| Puntaje | Regla | Acción |
|---|---|---|
| **A (caliente)** | Empieza en menos de 12 meses **y** ahorro ≥ 50 % de los fondos requeridos o financia con crédito/padres | WhatsApp del asesor el mismo día |
| **B (tibio)** | Empieza en 6–12 meses **o** ahorro entre 20 % y 50 % | Secuencia de correos + llamada en la semana |
| **C (frío)** | Más de 12 meses, "no sé", o ahorro menor al 20 % | Solo newsletter y alertas de cambios |

Incluye `lead_score`, UTMs y la página de origen en el envío.

**Botón de WhatsApp:** `https://wa.me/573014430722?text=` con un mensaje precargado que incluya destino, programa y costo calculado. Muestra también el número como texto seleccionable.

### 2.3 Medición
Usa el GA4 existente (`G-1RNV31B1EM`) y el Pixel de Meta (`1118856203755274`), respetando el consentimiento de cookies que ya tiene el sitio. Eventos:

| Evento | Cuándo |
|---|---|
| `calculo_realizado` | el usuario cambia país, programa o duración (con debounce, una vez por sesión y país) |
| `lead_paso1` | envía el correo |
| `lead_paso2` | completa el formulario de calificación (parámetro `lead_score`) |
| `whatsapp_click` | clic en WhatsApp (parámetros `pais`, `programa`) |
| `reporte_click` | clic en "Comprar reporte" |
| `reporte_compra` | regreso desde Wompi con pago aprobado (cuando exista la integración) |

Marca `lead_paso2` y `whatsapp_click` como conversiones en GA4 y como `Lead` en el Pixel.

### 2.4 Pago del reporte
Por ahora, botón con link de pago de Wompi (te lo paso cuando exista; deja una variable `WOMPI_LINK`). La entrega del PDF es manual por ahora con `generar_reporte.py`.

---

## 3. SEO técnico (requisitos obligatorios)

- **Una intención por URL.** Cada página por país responde una sola pregunta: "¿cuánto cuesta estudiar en [país] desde Colombia?".
- **Titles y meta descriptions** (plantillas):
  - Pilar: `Cuánto cuesta estudiar afuera desde Colombia (2026) | Calculadora en pesos` — meta: `Calcula en COP el costo de estudiar en Canadá, Reino Unido, Irlanda, Australia o Nueva Zelanda, la prueba de fondos de la visa y cuánto puedes ganar trabajando.`
  - País: `Cuánto cuesta estudiar en {País} desde Colombia en 2026 | CuántoAfuera` (máx. 60 caracteres; si no cabe, quita "| CuántoAfuera").
- **Un solo H1** por página, que repita la intención principal.
- **Contenido real en el HTML inicial.** Las páginas por país deben tener texto renderizado (no solo la calculadora en JS): tabla de costos, regla de fondos, permisos de trabajo, preguntas frecuentes. La calculadora va embebida y precargada con el país.
- **Fecha visible de verificación** en cada página ("Cifras verificadas al 7 de octubre de 2026") y `dateModified` en el schema. Al actualizar cifras, actualiza ambas.
- **Datos estructurados JSON-LD:**
  - Pilar: `WebApplication` (applicationCategory `FinanceApplication`, `offers` precio 0 COP) + `BreadcrumbList` + `FAQPage`.
  - Páginas por país: `Article` + `FAQPage` + `BreadcrumbList`.
  - `Organization` de Navia en el layout (si no existe ya).
  - Valida con Rich Results Test.
- **E-E-A-T:** caja de autor en cada página: "Revisado por Samuel Sánchez, fundador de Navia Global Education, 8 años en educación internacional, 500+ estudiantes asesorados, fundador con credencial British Council". **No escribir "agencia certificada"**: la credencial es personal del fundador.
- **Fuentes oficiales enlazadas** (IRCC, GOV.UK, Immigration Service Delivery, Home Affairs, Immigration New Zealand) en cada página por país. Esto es parte de la confianza y del SEO.
- **Enlazado interno:** cada artículo del blog enlaza a la calculadora con el país precargado (`/cuantoafuera/?pais=ca&programa=tecnico`, con `canonical` sin parámetros). Cada página por país enlaza a las otras 4 y a la guía de prueba de fondos.
- **Técnico:** `sitemap.xml` actualizado con las nuevas URLs, `robots.txt` sin bloquearlas, `canonical` en todas, `lang="es-CO"`, imágenes OG por país (1200×630), Core Web Vitals en verde (sin librerías externas; la calculadora ya es vanilla JS), y `noindex` en páginas de gracias.
- **Visibilidad en IA:** respuestas cortas y citables al inicio de cada página ("Estudiar un college de un año en Canadá desde Colombia cuesta aprox. $X COP en 2026, incluyendo…"), tablas en HTML y FAQ. Un `llms.txt` en la raíz que describa la herramienta.

---

## 4. Palabras clave objetivo

**Importante:** son hipótesis. **No hay volúmenes verificados.** Antes de escribir contenido, Samuel debe validarlas en Google Keyword Planner (Colombia, español) y luego en Search Console. Prioriza por volumen real y por intención comercial.

| Cluster | Palabras clave candidatas | Página destino | Intención |
|---|---|---|---|
| Costo general | cuánto cuesta estudiar en el exterior; cuánto cuesta estudiar afuera desde Colombia | `/cuantoafuera/` | Comercial |
| Costo por país | cuánto cuesta estudiar en Canadá / Irlanda / Australia / Reino Unido / Nueva Zelanda desde Colombia | `/cuantoafuera/{pais}/` | Comercial |
| Prueba de fondos | prueba de fondos visa de estudiante; cuánto dinero piden para la visa de estudiante {país} | `/cuantoafuera/prueba-de-fondos/` | Comercial alta |
| Trabajo | estudiar y trabajar en {país}; cuántas horas puede trabajar un estudiante en {país} | `/cuantoafuera/trabajar-mientras-estudias/` | Informativa→comercial |
| Inglés | cuánto cuesta estudiar inglés en Irlanda / Australia / Canadá | `/cuantoafuera/{pais}/ingles/` | Comercial |
| College/técnico | cuánto cuesta un college en Canadá para colombianos | `/cuantoafuera/canada/college/` | Comercial |
| Financiación | crédito para estudiar en el exterior; cómo ahorrar para estudiar afuera | blog | Informativa |

---

## 5. Plan de contenido (blog que alimenta la herramienta)

Cada artículo: 1.200–2.000 palabras, una intención, fuente oficial enlazada, caja de autor, CTA a la calculadora con el país precargado y CTA a WhatsApp.

| # | Título de trabajo | Página a la que empuja |
|---|---|---|
| 1 | Cuánto cuesta estudiar en Canadá desde Colombia en 2026 (con prueba de fondos de CAD 23.448) | `/cuantoafuera/canada/` |
| 2 | Cuánto cuesta estudiar inglés en Irlanda en 2026 y cuánto puedes ganar trabajando | `/cuantoafuera/irlanda/ingles/` |
| 3 | Prueba de fondos para visa de estudiante: cuánto piden los 5 países más buscados | `/cuantoafuera/prueba-de-fondos/` |
| 4 | Reino Unido sube los fondos el 30 de noviembre de 2026: cuánto debes mostrar ahora | `/cuantoafuera/reino-unido/` |
| 5 | Estudiar y trabajar: horas permitidas por país en 2026 | `/cuantoafuera/trabajar-mientras-estudias/` |
| 6 | Cuánto cuesta estudiar en Australia desde Colombia (visa de AUD 2.500) | `/cuantoafuera/australia/` |
| 7 | Cuánto cuesta estudiar en Nueva Zelanda desde Colombia (25 horas de trabajo) | `/cuantoafuera/nueva-zelanda/` |
| 8 | Cómo ahorrar para estudiar afuera: plan mes a mes | `/cuantoafuera/` (plan de ahorro) |
| 9 | Por qué rechazan la visa por fondos: 7 errores comunes de colombianos | `/cuantoafuera/prueba-de-fondos/` |
| 10 | Canadá vs. Irlanda para estudiar inglés y trabajar: comparativo de costos 2026 | `/cuantoafuera/` |
| 11 | Crédito educativo o patrocinio de padres: qué acepta cada embajada | `/cuantoafuera/prueba-de-fondos/` |
| 12 | Cuánto cuesta una maestría en Reino Unido desde Colombia | `/cuantoafuera/reino-unido/maestria/` |

Revisa los 8 artículos existentes del blog: agrégales enlaces a la calculadora donde tenga sentido.

---

## 6. Plan de trabajo de 90 días

### Semanas 1–2: base técnica (Claude Code)
- [ ] Inspeccionar repo y confirmar plan de Vercel
- [ ] Crear `/cuantoafuera/data/requisitos.json` y conectar la calculadora
- [ ] Integrar calculadora en `/cuantoafuera/` con header/footer y marca de Navia
- [ ] Formulario de dos pasos, `lead_score`, Formspree, WhatsApp con mensaje precargado
- [ ] Eventos GA4 y Pixel
- [ ] Privacidad y términos en `/cuantoafuera/privacidad/` y `/cuantoafuera/terminos/`
- [ ] Schema, sitemap, canonical, OG, `llms.txt`
- [ ] PR con resumen y checklist de pruebas

### Semanas 3–4: páginas por país (Claude Code + revisión de Samuel)
- [ ] 5 páginas por país con contenido renderizado, FAQ y calculadora precargada
- [ ] `/prueba-de-fondos/`, `/trabajar-mientras-estudias/` y `/cambios/`
- [ ] Enlaces desde los 8 artículos existentes
- [ ] Alta en Google Search Console y envío del sitemap (Samuel)

### Semanas 5–8: contenido y distribución (Samuel + Claude)
- [ ] Publicar artículos 1–6 (dos por semana)
- [ ] Artículo 4 (Reino Unido) **antes del 30 de noviembre de 2026**
- [ ] Reels/carruseles en @navia.global con un dato de cada artículo y link a la calculadora
- [ ] Campaña de pauta pequeña (parte de los ~$500 mil COP/mes ya asignados) a la calculadora, no a la home

### Semanas 9–12: optimización
- [ ] Publicar artículos 7–12
- [ ] Revisar en Search Console qué consultas traen impresiones y ajustar titles
- [ ] Fase 2: páginas país × tipo de programa (empezar por las que muestren impresiones)
- [ ] Revisar tasa de conversión del formulario y ajustar campos

### Mantenimiento permanente (calendario de actualización)

| Fecha | Qué revisar |
|---|---|
| 30 nov 2026 | Reino Unido: nuevos fondos (£1.570 Londres / £1.203 fuera) entran en vigor |
| 1 de enero cada año | Salario mínimo de Irlanda, montos de Quebec |
| 1 de julio cada año | Australia: tarifa de visa y salario mínimo |
| 1 de septiembre cada año | Canadá: nuevo monto de fondos (IRCC) |
| 1 de octubre cada año | Ontario: salario mínimo |
| Cada mes | Tasas de cambio de referencia |

Cada cambio se registra en `/cuantoafuera/cambios/` con fecha y fuente. Esa página también sirve como contenido fresco para SEO.

---

## 7. Metas (KPIs)

| Indicador | Mes 1 | Mes 3 | Mes 6 |
|---|---|---|---|
| Visitas a `/cuantoafuera/*` | 300 | 1.500 | 3.000 |
| Cálculos realizados / visitas | 40 % | 45 % | 50 % |
| Leads paso 1 / visitas | 5 % | 7 % | 8 % |
| Leads A+B por mes | 3 | 15 | 30 |
| Estudiantes cerrados atribuidos | 0 | 1 | 2–5 |
| Páginas en top 10 de Google | 0 | 3 | 8 |

Son metas de trabajo, no pronósticos. Ajustarlas con los datos reales del mes 1.

---

## 8. Criterios de aceptación del PR

- [ ] Ninguna URL existente se rompe (probar las 8 del blog y la home)
- [ ] Lighthouse móvil ≥ 90 en rendimiento, accesibilidad y SEO en `/cuantoafuera/` y una página de país
- [ ] Rich Results Test sin errores
- [ ] El formulario envía a Formspree con `lead_score`, UTMs y datos del cálculo
- [ ] Eventos visibles en GA4 DebugView
- [ ] La calculadora funciona sin cookies aceptadas (la medición no)
- [ ] Todas las cifras salen de `requisitos.json`; ninguna está escrita a mano en el HTML de la calculadora
- [ ] Cada página muestra fecha de verificación y fuentes oficiales
- [ ] Ningún texto promete aprobación de visa ni dice "agencia certificada"
- [ ] Funciona a 375 px de ancho sin scroll horizontal

---

## 9. Lo que NO debes hacer

- No publicar cifras sin fuente oficial ni fecha.
- No usar "agencia certificada British Council": la credencial es del fundador.
- No prometer aprobación de visa ni asesoría migratoria regulada.
- No agregar frameworks pesados ni CMS nuevos sin preguntarme.
- No hacer deploy a producción ni cambiar el plan de Vercel sin aprobación.
- No guardar datos personales fuera de Formspree/CRM (nada en `localStorage` salvo preferencias de la calculadora).

---

## 10. Datos verificados al 7 de octubre de 2026 (para `requisitos.json`)

| País | Fondos de vida para la visa | Tarifa de visa | Trabajo en clases | Salario mínimo ref. |
|---|---|---|---|---|
| Canadá | CAD 23.448/año (solicitudes desde 1 sep 2026, fuera de Quebec) + matrícula 1er año + tiquetes | CAD 150 (verificar) | 24 h/sem; ESL sin trabajo | CAD 17,95 (Ontario, desde 1 oct 2026) |
| Reino Unido | £1.529/mes Londres, £1.171 fuera, máx. 9 meses; desde 30 nov 2026: £1.570 / £1.203 | £558 + IHS ≈ £776/año | 20 h grado+, 10 h por debajo; inglés independiente sin trabajo | £12,71 (verificar) |
| Irlanda | €10.000/año; €833/mes si < 8 meses | €60 / €100 | 20 h; 40 h del 1 jun al 30 sep y del 15 dic al 15 ene | €14,15 (desde ene 2026) |
| Australia | AUD 29.710/año | AUD 2.500 (desde 1 jul 2026, verificar) | 48 h cada 2 semanas | AUD 26,44 (desde 1 jul 2026) |
| Nueva Zelanda | NZD 20.000/año; NZD 1.667/mes si < 1 año | ≈ NZD 850 + IVL (verificar) | 25 h/sem; inglés 14+ semanas con proveedor Categoría 1 | NZD 23,15 (verificar) |

TRM USD de referencia: $3.307,73 (2 oct 2026). Las demás tasas de cambio del prototipo son aproximadas.
