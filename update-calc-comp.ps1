$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# ── 1. HTML: Agregar Francia y Alemania al select de la calculadora ────────
$html = $html.Replace(
'                    <option value="uk">Reino Unido</option>
                </select>

                <select id="calc-duracion"',
'                    <option value="uk">Reino Unido</option>
                    <option value="francia">Francia</option>
                    <option value="alemania">Alemania</option>
                </select>

                <select id="calc-duracion"'
)

# ── 2. HTML: Actualizar los dos selects del comparador (10 paises) ─────────
$oldSelect1 = '<select id="comp-pais1">
                        <option value="">Selecciona pa' + [char]237 + 's 1</option>
                        <option value="australia">Australia</option>
                        <option value="canada">Canad' + [char]225 + '</option>
                        <option value="irlanda">Irlanda</option>
                        <option value="malta">Malta</option>
                    </select>'

$newSelectOptions = '<option value="">Selecciona pa' + [char]237 + 's</option>
                        <option value="australia">🇦🇺 Australia</option>
                        <option value="nz">🇳🇿 Nueva Zelanda</option>
                        <option value="irlanda">🇮🇪 Irlanda</option>
                        <option value="malta">🇲🇹 Malta</option>
                        <option value="dubai">🇦🇪 Dubai</option>
                        <option value="canada">🇨🇦 Canad' + [char]225 + '</option>
                        <option value="usa">🇺🇸 Estados Unidos</option>
                        <option value="uk">🇬🇧 Reino Unido</option>
                        <option value="francia">🇫🇷 Francia</option>
                        <option value="alemania">🇩🇪 Alemania</option>'

$html = $html.Replace(
'<select id="comp-pais1">
                        <option value="">Selecciona pa' + [char]237 + 's 1</option>
                        <option value="australia">Australia</option>
                        <option value="canada">Canad' + [char]225 + '</option>
                        <option value="irlanda">Irlanda</option>
                        <option value="malta">Malta</option>
                    </select>',
'<select id="comp-pais1">' + "`n                        " + $newSelectOptions + "`n                    </select>"
)

$html = $html.Replace(
'<select id="comp-pais2">
                        <option value="">Selecciona pa' + [char]237 + 's 2</option>
                        <option value="australia">Australia</option>
                        <option value="canada">Canad' + [char]225 + '</option>
                        <option value="irlanda">Irlanda</option>
                        <option value="malta">Malta</option>
                    </select>',
'<select id="comp-pais2">' + "`n                        " + $newSelectOptions + "`n                    </select>"
)

# ── 3. JS: Reemplazar la funcion completa de la calculadora ───────────────
$oldCalc = '        // ========== CALCULADORA DE COSTOS DE PROGRAMAS (SIMPLIFICADA) ==========
        function calcularProgramaSimple() {'
$calcStart = $html.IndexOf($oldCalc)
$calcEnd = $html.IndexOf('        // ========== COMPARADOR DE DESTINOS ==========')
$beforeCalc = $html.Substring(0, $calcStart)
$afterCalc = $html.Substring($calcEnd)

$newCalc = @'
        // ========== CALCULADORA DE COSTOS — PRECIOS REALES 2026 ==========
        function calcularProgramaSimple() {
            const destino = document.getElementById('calc-destino').value;
            const semanas = document.getElementById('calc-duracion').value;
            const intensidad = document.getElementById('calc-intensidad').value;

            if (!destino || !semanas || !intensidad) {
                alert('Por favor completa todos los campos');
                return;
            }

            // Precios reales por semana en moneda local (general = base 6 meses)
            // Fuente: cotizaciones reales Navia Global 2026
            const destinoInfo = {
                australia: { nombre: 'Australia 🇦🇺',         moneda: 'AUD', part: 200, general: 250, intensive: 313 },
                nz:        { nombre: 'Nueva Zelanda 🇳🇿',     moneda: 'NZD', part: 200, general: 250, intensive: 313 },
                irlanda:   { nombre: 'Irlanda 🇮🇪',           moneda: 'EUR', part: 100, general: 125, intensive: 156 },
                malta:     { nombre: 'Malta 🇲🇹',             moneda: 'EUR', part: 107, general: 133, intensive: 167 },
                dubai:     { nombre: 'Dubai 🇦🇪',             moneda: 'USD', part: 133, general: 167, intensive: 208 },
                canada:    { nombre: 'Canadá 🇨🇦',       moneda: 'CAD', part: 133, general: 167, intensive: 208 },
                usa:       { nombre: 'Estados Unidos 🇺🇸',    moneda: 'USD', part: 167, general: 208, intensive: 260 },
                uk:        { nombre: 'Reino Unido 🇬🇧',       moneda: 'GBP', part: 188, general: 235, intensive: 293 },
                francia:   { nombre: 'Francia 🇫🇷',           moneda: 'EUR', part: 167, general: 208, intensive: 260 },
                alemania:  { nombre: 'Alemania 🇩🇪',          moneda: 'EUR', part: 133, general: 167, intensive: 208 }
            };

            const nombreIntensidad = {
                part:      'Part-time (15 hrs/semana)',
                general:   'General (20 hrs/semana)',
                intensive: 'Intensive (25-30 hrs/semana)'
            };

            const info = destinoInfo[destino];
            const numSemanas = parseInt(semanas);
            const precioPorSemana = info[intensidad];
            const total = precioPorSemana * numSemanas;
            const meses = (numSemanas / 4).toFixed(1).replace('.0','');
            const duracionTexto = numSemanas < 8 ? numSemanas + ' semanas' : numSemanas + ' semanas (' + meses + ' meses)';

            const notaIrlanda = (destino === 'irlanda' && numSemanas === 25)
                ? '<br><strong style="color:#1ABC9C;">✅ Programa especial 25 sem = visa de estudiante con permiso de trabajo</strong>' : '';

            document.getElementById('precio-total').textContent = info.moneda + ' ' + total.toLocaleString();
            document.getElementById('calc-detalles').innerHTML =
                '<strong>Destino:</strong> ' + info.nombre + '<br>' +
                '<strong>Duración:</strong> ' + duracionTexto + '<br>' +
                '<strong>Tipo:</strong> ' + nombreIntensidad[intensidad] + '<br>' +
                '<strong>Precio por semana:</strong> ' + info.moneda + ' ' + precioPorSemana.toLocaleString() + '<br>' +
                '<strong>Total del curso:</strong> ' + info.moneda + ' ' + total.toLocaleString() +
                notaIrlanda + '<br><br>' +
                '<em style="color:#888;font-size:0.85rem;">Precio solo matrícula del curso de idiomas. No incluye visa, alojamiento, vuelos ni seguro. Basado en cotizaciones reales 2026.</em>';

            document.getElementById('calc-result').classList.add('active');
            document.getElementById('calc-result').scrollIntoView({ behavior: 'smooth', block: 'nearest' });

            if (typeof gtag !== 'undefined') {
                gtag('event', 'calculadora_programas', { event_category: 'Herramientas', event_label: destino + ' - ' + semanas + 'sem - ' + intensidad });
            }
        }

'@

$html = $beforeCalc + $newCalc + $afterCalc

# ── 4. JS: Reemplazar dataPaises en el comparador ─────────────────────────
$oldData = '            // Datos de comparaci' + [char]243 + 'n
            const dataPaises = {'
$dataStart = $html.IndexOf($oldData)
$dataEnd = $html.IndexOf('            const data1 = dataPaises[pais1];')
$beforeData = $html.Substring(0, $dataStart)
$afterData = $html.Substring($dataEnd)

$newData = @'
            // Datos de comparacion — actualizados 2026 con precios reales Navia Global
            const dataPaises = {
                australia: {
                    nombre: '<img src="https://flagcdn.com/w40/au.png" width="20" style="vertical-align:middle;margin-right:5px;"> Australia',
                    costo: 'AUD $6,000 / 6 meses',
                    trabajo: '24h/semana (48h quincenales)',
                    clima: 'Templado / Cálido',
                    salario: 'AUD $24.95/hora',
                    idioma: 'Inglés',
                    postEstudio: 'Visa 485 (2–4 años)',
                    ciudades: 'Sydney, Melbourne, Brisbane'
                },
                nz: {
                    nombre: '<img src="https://flagcdn.com/w40/nz.png" width="20" style="vertical-align:middle;margin-right:5px;"> Nueva Zelanda',
                    costo: 'NZD $6,000 / 6 meses',
                    trabajo: '25h/semana',
                    clima: 'Templado',
                    salario: 'NZD $23.15/hora',
                    idioma: 'Inglés',
                    postEstudio: 'Post Study Work 3 años',
                    ciudades: 'Auckland, Wellington, Christchurch'
                },
                irlanda: {
                    nombre: '<img src="https://flagcdn.com/w40/ie.png" width="20" style="vertical-align:middle;margin-right:5px;"> Irlanda',
                    costo: 'EUR €3,000 / 25 semanas',
                    trabajo: '20h/semana (40h vacaciones)',
                    clima: 'Templado / Lluvioso',
                    salario: 'EUR €13.50/hora',
                    idioma: 'Inglés',
                    postEstudio: 'Stay Back graduados (limitado)',
                    ciudades: 'Dublín, Cork, Galway'
                },
                malta: {
                    nombre: '<img src="https://flagcdn.com/w40/mt.png" width="20" style="vertical-align:middle;margin-right:5px;"> Malta',
                    costo: 'EUR €3,200 / 6 meses',
                    trabajo: '20h/semana',
                    clima: 'Mediterráneo',
                    salario: 'EUR €5.42/hora',
                    idioma: 'Inglés / Maltés',
                    postEstudio: 'Limitado',
                    ciudades: 'Valletta, Sliema, St. Julian’s'
                },
                dubai: {
                    nombre: '<img src="https://flagcdn.com/w40/ae.png" width="20" style="vertical-align:middle;margin-right:5px;"> Dubai',
                    costo: 'USD $4,000 / 6 meses',
                    trabajo: 'Varía según escuela',
                    clima: 'Désrtico / Muy cálido',
                    salario: 'Sin salario mínimo',
                    idioma: 'Inglés / Árabe',
                    postEstudio: 'Limitado',
                    ciudades: 'Dubái, Abu Dhabi'
                },
                canada: {
                    nombre: '<img src="https://flagcdn.com/w40/ca.png" width="20" style="vertical-align:middle;margin-right:5px;"> Canadá',
                    costo: 'CAD $4,000 / 6 meses',
                    trabajo: '20h/semana',
                    clima: 'Frío',
                    salario: 'CAD ~$17/hora (varía prov.)',
                    idioma: 'Inglés / Francés',
                    postEstudio: 'PGWP hasta 3 años + PR pathway',
                    ciudades: 'Toronto, Vancouver, Montreal'
                },
                usa: {
                    nombre: '<img src="https://flagcdn.com/w40/us.png" width="20" style="vertical-align:middle;margin-right:5px;"> Estados Unidos',
                    costo: 'USD $5,000 / 6 meses',
                    trabajo: 'No permitido (F-1 primer año)',
                    clima: 'Varía por ciudad',
                    salario: 'USD $7.25+/hora (varía estado)',
                    idioma: 'Inglés',
                    postEstudio: 'OPT hasta 3 años (STEM)',
                    ciudades: 'Nueva York, Miami, Boston, LA'
                },
                uk: {
                    nombre: '<img src="https://flagcdn.com/w40/gb.png" width="20" style="vertical-align:middle;margin-right:5px;"> Reino Unido',
                    costo: 'GBP ~£4,500 / 6 meses',
                    trabajo: '20h/semana',
                    clima: 'Templado / Lluvioso',
                    salario: 'GBP £11.44/hora',
                    idioma: 'Inglés',
                    postEstudio: 'Graduate Route 2–3 años',
                    ciudades: 'Londres, Manchester, Edimburgo'
                },
                francia: {
                    nombre: '<img src="https://flagcdn.com/w40/fr.png" width="20" style="vertical-align:middle;margin-right:5px;"> Francia',
                    costo: 'EUR €5,000 / 6 meses',
                    trabajo: '20h/semana',
                    clima: 'Templado / Continental',
                    salario: 'EUR €11.88/hora (SMIC)',
                    idioma: 'Francés / Inglés',
                    postEstudio: 'Limitado',
                    ciudades: 'París, Lyon, Niza, Burdeos'
                },
                alemania: {
                    nombre: '<img src="https://flagcdn.com/w40/de.png" width="20" style="vertical-align:middle;margin-right:5px;"> Alemania',
                    costo: 'EUR €4,000 / 6 meses',
                    trabajo: '20h/semana',
                    clima: 'Continental / Frío',
                    salario: 'EUR €12.82/hora (Mindestlohn)',
                    idioma: 'Alemán / Inglés',
                    postEstudio: 'Job Seeker Visa hasta 18 meses',
                    ciudades: 'Berlín, Múnich, Hamburgo'
                }
            };

'@

$html = $beforeData + $newData + $afterData

[System.IO.File]::WriteAllText($path, $html, $enc)
Write-Host "[OK] Calculadora y comparador actualizados con datos reales 2026"
Write-Host "  - 10 paises en calculadora (+ Francia, Alemania)"
Write-Host "  - Precios en moneda local (AUD, NZD, EUR, CAD, USD, GBP)"
Write-Host "  - 10 paises en comparador con datos reales"
