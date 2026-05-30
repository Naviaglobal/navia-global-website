# Contexto del Proyecto — Navia Global Website
> Archivo de referencia para nuevas conversaciones con Claude. Actualizado: Mayo 2026.

---

## 🏢 El Negocio

**Navia Global Education SAS** — Agencia colombiana de estudios en el exterior fundada en 2017.
- **Fundador**: Samuel Sánchez — ex-estudiante internacional, +8 años de experiencia
- **WhatsApp**: 301 4430722
- **Email**: info@naviaglobal.co / samuel.sanchez@naviaglobal.co
- **Web**: https://naviaglobal.co
- **Misión**: Llevar colombianos a estudiar al exterior. Asesoría 100% gratuita.

### Destinos activos
Australia 🇦🇺 | Irlanda 🇮🇪 | Canadá 🇨🇦 | Malta 🇲🇹 | Dubai 🇦🇪 | Nueva Zelanda 🇳🇿 | Reino Unido 🇬🇧 | Estados Unidos 🇺🇸 | Francia 🇫🇷 | Alemania 🇩🇪

---

## 🖥️ Infraestructura Técnica

| Componente | Detalle |
|-----------|---------|
| **Tipo de sitio** | HTML estático puro (sin CMS, sin framework) |
| **Hosting** | Vercel — proyecto `navia-generador-anuncios` |
| **Dominio** | naviaglobal.co |
| **Deploy** | Script PowerShell: `C:\Users\User\.claude\navia-website\deploy-fix.ps1` |
| **Archivos locales** | `C:\Users\User\.claude\navia-website\` |
| **Formularios** | Formspree — endpoint: `https://formspree.io/f/xdkpereb` |
| **Analytics** | Google Analytics: `G-1RNV31B1EM` |
| **Meta Pixel** | `1941742975996934` (Navia global) — en todos los archivos |
| **Meta Ads Account** | `140962951180245` (Navia Global portfolio) |

### Deploy
```powershell
# Desplegar a producción:
powershell.exe -ExecutionPolicy Bypass -File "C:\Users\User\.claude\navia-website\deploy-fix.ps1"
```

### Editar archivos
```powershell
# Siempre usar UTF-8 explícito:
$c = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($path, $c, [System.Text.Encoding]::UTF8)
```

---

## 📁 Estructura de Archivos

```
navia-website/
├── index.html                    # Homepage principal
├── contacto.html                 # Página de contacto
├── sobre-samuel-sanchez.html     # Sobre Samuel
├── gracias.html                  # Página post-formulario
├── sitemap.xml                   # 81 URLs
├── robots.txt
├── logo.webp
│
├── australia/index.html          # Landing destino
├── irlanda/index.html
├── canada/index.html
├── malta/index.html
├── dubai/index.html
├── nueva-zelanda/index.html
├── reino-unido/index.html
├── estados-unidos/index.html
├── francia/index.html
├── alemania/index.html
│
├── blog/
│   ├── index.html               # Blog index — 67 artículos
│   └── [67 artículos .html]
│
├── deploy-fix.ps1               # Script de deploy
├── add-pixel.ps1                # Script pixel Meta
├── check-links.ps1              # Audit de enlaces
├── fix-links.ps1                # Corrección de enlaces
└── add-faq-schema.ps1           # FAQPage schema
```

---

## ✅ Estado Actual del SEO (Mayo 2026)

### Lo que está implementado
- ✅ **67 artículos** en el blog, sin duplicados
- ✅ **10 landings** de destino con formulario de leads + pixel
- ✅ **FAQPage JSON-LD** en los 10 landings (5 preguntas c/u)
- ✅ **Sitemap.xml** con 84 URLs registradas
- ✅ **robots.txt** configurado
- ✅ **Meta Pixel** `1941742975996934` en todos los archivos HTML
- ✅ **Google Analytics** `G-1RNV31B1EM` en todo el sitio
- ✅ **0 enlaces rotos** (auditado y corregido)
- ✅ **Mobile CTA bar** en artículos principales
- ✅ **Artículos relacionados** en 4 blogs nuevos
- ✅ **Blog redesign**: sidebar PC + drawer mobile + scroll virtual

### GSC Indexación solicitada (Mayo 2026)
- `/blog/working-holiday-visa-colombia.html`
- `/blog/requisitos-estudiar-exterior-colombia.html`
- `/blog/como-financiar-estudios-exterior-colombia.html`
- `/blog/vivir-estudiar-canada-colombianos.html`

### Pendiente
- [ ] AggregateRating schema (cuando haya 5+ reseñas Google)
- [ ] Backlinks: Universia, ICETEX, EduOpiniones, LanguageCourse.net
- [ ] Google Business Profile: posts semanales + reseñas
- [ ] n8n API key renovar (expiró Mayo 13, 2026)

---

## 🎨 Marca Navia Global

| Elemento | Valor |
|---------|-------|
| **Color principal** | Azul `#1B4B8C` |
| **Color acento** | Verde teal `#1ABC9C` |
| **Tono de voz** | Cercano, experto, sin tecnicismos. Como un amigo que ya estudió afuera. |
| **CTA principal** | "Asesoría 100% gratuita" → WhatsApp |
| **Datos clave** | +500 estudiantes, +8 años experiencia, desde 2017 |

### Datos correctos (verificados Mayo 2026)
| Dato | Valor correcto |
|------|---------------|
| Número de guías | **67 guías** |
| Salario Australia | **AUD $24.95/hora** |
| Salario Irlanda | **EUR €13.50/hora** |
| Años experiencia | **+8 años** (desde 2017) |

---

## 📝 Formularios de Leads

**Endpoint Formspree**: `https://formspree.io/f/xdkpereb`

Todos los formularios en las 10 landings usan:
- Campos: nombre, whatsapp, email, interes (select), mensaje, checkbox privacy
- Hidden fields: `destino`, `fuente`, `_subject`, `_cc: samuel.sanchez@naviaglobal.co`, `_next: /gracias.html`
- AJAX submit con `fetch()` + `Accept: application/json`
- On success: `fbq('track','Lead')` + `gtag('event','generate_lead')`
- Fallback error: abre WhatsApp

---

## 📱 Blog Index (`/blog/`)

### Estructura
- **PC**: Sidebar fija izquierda (248px) con 16 categorías en 2 grupos
- **Mobile**: Botón flotante `🗂️` → drawer desde abajo con las mismas categorías
- **Scroll virtual**: 15 cards iniciales + 12 más por IntersectionObserver
- **Filtros**: 16 categorías mapeadas a `data-categories` en cada card

### Categorías del sidebar
**Destinos**: australia, irlanda, canada, europa, reino, usa, malta, alemania
**Temas**: visa, trabajo, economia, comparativa, ciudad, ingles, proceso, prestigio

---

## 📊 Campañas Meta Ads (Activas)

- **Cuenta**: `140962951180245` — Navia Global
- **Campañas activas**: IR-03_Carrusel_Irlanda, IR-01_Reel_Irlanda
- **Objetivo**: Conversaciones con mensajes
- **Presupuesto diario**: $50,000 COP por campaña
- **Pixel activo**: `1628049611726524` (Navia Lead Agent)
- **Eventos trackeados**: PageView (todas las páginas), Lead (formularios), ViewContent (artículos)

---

## 🔧 Scripts de Mantenimiento

| Script | Propósito |
|--------|-----------|
| `deploy-fix.ps1` | Deploy a Vercel |
| `add-pixel.ps1` | Inyectar/corregir Meta Pixel en todos los HTML |
| `check-links.ps1` | Audit de enlaces rotos |
| `fix-links.ps1` | Corregir enlaces rotos mapeados |
| `add-faq-schema.ps1` | Insertar FAQPage JSON-LD en landings |
| `blog-redesign.ps1` | Rediseño sidebar/drawer blog index |

---

## 🔑 Credenciales y IDs clave

| Sistema | ID / Dato |
|---------|-----------|
| Google Analytics | `G-1RNV31B1EM` |
| Meta Pixel (website) | `1628049611726524` |
| Meta Ads Account | `140962951180245` |
| Formspree | `xdkpereb` |
| Vercel proyecto | `navia-generador-anuncios` |
| WhatsApp CTA | `https://wa.me/573014430722` |

---

## 💡 Patrones Técnicos Importantes

### Modificar HTML desde PowerShell
```powershell
$f = 'C:\Users\User\.claude\navia-website\blog\index.html'
$c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
$c = $c.Replace('VIEJO', 'NUEVO')
[System.IO.File]::WriteAllText($f, $c, [System.Text.Encoding]::UTF8)
```

### Insertar HTML antes de tag
```powershell
$c = $c.Replace('</head>', $nuevoHTML + '</head>')
$c = $c.Replace('</body>', $nuevoHTML + '</body>')
```

### Evitar problemas de encoding
- Nunca usar acentos o caracteres especiales en strings de PS
- Usar entidades HTML: `&#233;` en vez de `é`
- Siempre `[System.Text.Encoding]::UTF8` explícito

### Blog index es un archivo largo (~146KB)
- No se puede leer completo con Read tool (límite 25K tokens)
- Usar PowerShell para modificaciones
- Usar Grep para buscar patrones específicos

---

*Generado automáticamente por Claude — Navia Global SEO Session Mayo 2026*
