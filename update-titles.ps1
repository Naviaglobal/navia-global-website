$enc = New-Object System.Text.UTF8Encoding($false)
$base = 'C:\Users\User\.claude\navia-website\blog'

$updates = @(
    # --- Main country guides ---
    @{ file='estudiar-australia-colombia-2026.html';              title='Estudiar en Australia 2026: Trabaja 24h/semana y Gana AUD $24.95/h | Navia Global';                   desc='Visa subclase 500, salario minimo AUD $24.95/h y costos reales para estudiantes colombianos en Australia 2026. Guia verificada por British Council.' },
    @{ file='estudiar-irlanda-colombia-2026.html';                title='Estudiar en Irlanda 2026: Visa EUR 60 y Trabaja 20h/semana | Navia Global';                            desc='Visa de estudiante EUR 60, salario EUR 13.50/h y costos de vida para colombianos en Irlanda 2026. Datos oficiales actualizados.' },
    @{ file='estudiar-nueva-zelanda-colombia-2026.html';          title='Estudiar en Nueva Zelanda 2026: Trabaja 25h/semana Legalmente | Navia Global';                         desc='Visa NZD $850, salario NZD $23.15/h y costos reales de vida para estudiantes colombianos en Nueva Zelanda 2026.' },
    @{ file='estudiar-canada-colombia-2026.html';                 title='Estudiar en Canada 2026: Study Permit, Trabajo 24h y Costos | Navia Global';                           desc='Study Permit Canada, salario minimo CAD $17.30/h, trabajo 24h/semana y costos de vida para colombianos. Guia mayo 2026.' },
    @{ file='estudiar-reino-unido-colombia-2026.html';            title='Estudiar en Reino Unido 2026: Visa Student y Trabaja 20h/semana | Navia Global';                       desc='Visa Student UK GBP 490, salario GBP 11.44/h y costos reales para estudiantes colombianos en Reino Unido 2026.' },
    @{ file='estudiar-estados-unidos-colombia-2026.html';         title='Estudiar en Estados Unidos 2026: Visa F-1 Paso a Paso para Colombianos | Navia Global';               desc='Visa F-1 USA, SEVIS, costos de universidades y vida para estudiantes colombianos en Estados Unidos 2026. Datos oficiales.' },
    @{ file='estudiar-alemania-colombia-2026.html';               title='Estudiar en Alemania 2026: Universidades Gratuitas para Colombianos | Navia Global';                   desc='Estudia gratis en Alemania, visa EUR 75, salario EUR 12.82/h y costos de vida para colombianos. Guia actualizada mayo 2026.' },
    @{ file='estudiar-francia-colombia-2026.html';                title='Estudiar en Francia 2026: Universidades Publicas y Costos para Colombianos | Navia Global';            desc='Universidades publicas en Francia desde EUR 170/ano, visa estudiante y costos de vida para colombianos 2026.' },
    @{ file='estudiar-malta-colombia-2026.html';                  title='Estudiar Ingles en Malta 2026: Clima, Visa Schengen y Costos Reales | Navia Global';                   desc='Malta para estudiar ingles: clima europeo, visa Schengen, costos desde EUR 900/mes para colombianos. Datos mayo 2026.' },
    @{ file='estudiar-dubai-colombia-2026.html';                  title='Estudiar en Dubai 2026: Visa Estudiante y Costos para Colombianos | Navia Global';                     desc='Visa de estudiante en Dubai, costos de vida en AED y oportunidades para colombianos en Emiratos Arabes. Datos 2026.' },
    # --- Visa guides ---
    @{ file='visa-estudiante-australia-2026.html';                title='Visa Estudiante Australia 2026: Subclase 500 Paso a Paso | Navia Global';                              desc='Requisitos, documentos y costos de la visa subclase 500 de Australia para colombianos. Guia verificada mayo 2026.' },
    @{ file='visa-estudiante-canada-2026.html';                   title='Visa Estudiante Canada 2026: Study Permit desde Colombia | Navia Global';                              desc='Requisitos y paso a paso para el Study Permit de Canada desde Colombia. Costos y tiempos de proceso mayo 2026.' },
    @{ file='visa-estudiante-irlanda-colombia-2026.html';         title='Visa Estudiante Irlanda 2026: EUR 60 y Proceso para Colombianos | Navia Global';                       desc='Visa de estudiante en Irlanda EUR 60, documentos requeridos y proceso desde Colombia. Datos oficiales mayo 2026.' },
    @{ file='visa-estudiante-nueva-zelanda-colombia-2026.html';   title='Visa Estudiante Nueva Zelanda 2026: NZD $850 para Colombianos | Navia Global';                         desc='Student Visa Nueva Zelanda NZD $850, requisitos y proceso desde Colombia. Guia actualizada mayo 2026.' },
    @{ file='visa-estudiante-reino-unido-colombia-2026.html';     title='Visa Student UK 2026: Requisitos y Costos para Colombianos | Navia Global';                            desc='Visa Student Reino Unido GBP 490 + IHS, requisitos y proceso para colombianos. Guia oficial mayo 2026.' },
    @{ file='visa-estudiante-estados-unidos-colombia-2026.html';  title='Visa F-1 USA 2026: Requisitos y Proceso para Colombianos | Navia Global';                              desc='Visa F-1 de estudiante para USA, SEVIS, entrevista consular y requisitos para colombianos. Datos mayo 2026.' },
    @{ file='visa-estudiante-alemania-colombia-2026.html';        title='Visa Estudiante Alemania 2026: EUR 75 y Proceso para Colombianos | Navia Global';                      desc='Visa de estudiante en Alemania EUR 75, requisitos, documentos y proceso desde Colombia. Guia mayo 2026.' },
    @{ file='visa-estudiante-malta-colombia-2026.html';           title='Visa para Estudiar en Malta 2026: Schengen para Colombianos | Navia Global';                           desc='Visa Schengen para estudiar en Malta, requisitos y costos para colombianos. Informacion oficial mayo 2026.' },
    @{ file='visa-estudiante-dubai-colombia-2026.html';           title='Visa Estudiante Dubai 2026: Emiratos Arabes para Colombianos | Navia Global';                          desc='Visa de estudiante en Dubai y Emiratos Arabes, requisitos y costos para colombianos. Datos actualizados 2026.' },
    @{ file='visa-schengen-colombianos-2026.html';                title='Visa Schengen 2026 para Colombianos: Requisitos y Como Aplicar | Navia Global';                        desc='Guia completa de visa Schengen para colombianos 2026: documentos, costos EUR 90 y como evitar rechazos.' },
    @{ file='requisitos-visa-trabajo-australia-colombia.html';    title='Visa de Trabajo Australia 2026: Opciones para Colombianos | Navia Global';                             desc='Visas de trabajo en Australia para colombianos: Working Holiday, Employer Sponsored y mas. Datos oficiales 2026.' },
    # --- City study guides ---
    @{ file='estudiar-ingles-dublin-colombia.html';               title='Estudiar Ingles en Dublin 2026: Escuelas y Costos para Colombianos | Navia Global';                    desc='Las mejores escuelas de ingles en Dublin, visa EUR 60 y costos de vida para estudiantes colombianos. Mayo 2026.' },
    @{ file='estudiar-ingles-cork-colombia.html';                 title='Estudiar Ingles en Cork Irlanda 2026: Alternativa a Dublin | Navia Global';                            desc='Cork: estudia ingles a menor costo que Dublin, escuelas recomendadas y costos para colombianos. Datos 2026.' },
    @{ file='estudiar-ingles-auckland-colombia.html';             title='Estudiar Ingles en Auckland 2026: Escuelas y Costos Reales | Navia Global';                            desc='Escuelas de ingles en Auckland, visa NZD $850 y costos reales para estudiantes colombianos en NZ 2026.' },
    @{ file='estudiar-ingles-toronto-colombia.html';              title='Estudiar Ingles en Toronto 2026: Escuelas y Costos para Colombianos | Navia Global';                   desc='Las mejores escuelas de ingles en Toronto, Study Permit Canada y costos de vida para colombianos 2026.' },
    @{ file='estudiar-ingles-sydney-colombia.html';               title='Estudiar Ingles en Sydney 2026: Escuelas y Costos Reales | Navia Global';                              desc='Escuelas de ingles en Sydney, visa subclase 500 y costos de vida para estudiantes colombianos. Guia mayo 2026.' },
    @{ file='estudiar-ingles-melbourne-colombia.html';            title='Estudiar Ingles en Melbourne 2026: Escuelas y Costos para Colombianos | Navia Global';                 desc='Melbourne para estudiar ingles: escuelas ELICOS, visa AUD y costos reales de vida para colombianos 2026.' },
    @{ file='estudiar-ingles-vancouver-colombia.html';            title='Estudiar Ingles en Vancouver 2026: Escuelas y Costos para Colombianos | Navia Global';                 desc='Las mejores escuelas de ingles en Vancouver, Study Permit Canada y costos de vida. Datos mayo 2026.' },
    @{ file='estudiar-ingles-londres-colombia.html';              title='Estudiar Ingles en Londres 2026: Escuelas y Costos para Colombianos | Navia Global';                   desc='Escuelas de ingles en Londres, Visa Student UK y costos reales de vida para colombianos. Guia mayo 2026.' },
    @{ file='estudiar-ingles-manchester-colombia.html';           title='Estudiar Ingles en Manchester 2026: Alternativa Economica a Londres | Navia Global';                   desc='Manchester: estudia ingles a menor costo que Londres, Visa Student UK y costos para colombianos. Datos 2026.' },
    @{ file='estudiar-ingles-nueva-york-colombia.html';           title='Estudiar Ingles en Nueva York 2026: Escuelas y Costos para Colombianos | Navia Global';               desc='Escuelas de ingles en Nueva York, visa F-1 y costos de vida para estudiantes colombianos en USA. Mayo 2026.' },
    # --- Comparison articles ---
    @{ file='mejor-pais-estudiar-ingles-colombia-2026.html';      title='Mejor Pais para Estudiar Ingles en 2026: Ranking para Colombianos | Navia Global';                     desc='Comparativa completa: Australia, Canada, Irlanda, NZ, UK y Malta para colombianos. Costos, visas y salarios 2026.' },
    @{ file='mejores-ciudades-estudiar-ingles-2026.html';         title='Mejores Ciudades para Estudiar Ingles en 2026: Guia para Colombianos | Navia Global';                  desc='Ranking de ciudades para estudiar ingles: Dublin, Toronto, Sydney, Auckland y mas. Costos reales mayo 2026.' },
    @{ file='australia-vs-canada-colombianos-2026.html';          title='Australia vs Canada 2026: Donde Estudiar si Eres Colombiano | Navia Global';                           desc='Comparativa definitiva Australia vs Canada para colombianos: visa, salario, costos y clima. Datos mayo 2026.' },
    @{ file='australia-vs-irlanda-colombianos-2026.html';         title='Australia vs Irlanda 2026: Cual Elegir para Estudiar Ingles | Navia Global';                           desc='Australia vs Irlanda para colombianos: visa, AUD $24.95 vs EUR 13.50/h, costos y diferencias clave. Mayo 2026.' },
    @{ file='canada-vs-reino-unido-colombianos-2026.html';        title='Canada vs Reino Unido 2026: Donde Estudiar Ingles como Colombiano | Navia Global';                     desc='Canada vs UK para colombianos: Study Permit vs Visa Student, salarios y costos comparados. Datos 2026.' },
    @{ file='dublin-vs-cork-colombia.html';                       title='Dublin vs Cork 2026: Donde Estudiar Ingles en Irlanda | Navia Global';                                 desc='Dublin vs Cork para estudiar ingles: costos, escuelas y calidad de vida para colombianos en Irlanda 2026.' },
    @{ file='malta-vs-irlanda-colombianos-2026.html';             title='Malta vs Irlanda 2026: Cual es Mejor para Estudiar Ingles | Navia Global';                             desc='Malta vs Irlanda para colombianos: clima, costos, visas y calidad de vida comparados. Datos mayo 2026.' },
    @{ file='sydney-vs-melbourne-colombia.html';                  title='Sydney vs Melbourne 2026: Donde Estudiar Ingles en Australia | Navia Global';                          desc='Sydney vs Melbourne para estudiantes colombianos: costos, escuelas y estilo de vida comparados. Datos 2026.' },
    @{ file='toronto-vs-vancouver-colombia.html';                 title='Toronto vs Vancouver 2026: Donde Estudiar Ingles en Canada | Navia Global';                            desc='Toronto vs Vancouver para colombianos: costos, escuelas, clima y oportunidades laborales comparados. Mayo 2026.' },
    @{ file='londres-vs-manchester-colombia.html';                title='Londres vs Manchester 2026: Donde Estudiar Ingles en UK | Navia Global';                               desc='Londres vs Manchester para estudiantes colombianos: costos, escuelas y vida estudiantil comparados. Datos 2026.' },
    @{ file='nueva-york-vs-miami-colombia.html';                  title='Nueva York vs Miami 2026: Donde Estudiar Ingles en USA | Navia Global';                                desc='Nueva York vs Miami para colombianos: costos, escuelas, comunidad latina y visa F-1. Datos mayo 2026.' },
    # --- Practical / how-to ---
    @{ file='trabajar-mientras-estudias-exterior.html';           title='Trabajar Mientras Estudias en el Exterior 2026: Horas y Salarios | Navia Global';                      desc='Cuantas horas puedes trabajar con visa de estudiante en Australia, Canada, Irlanda y NZ. Salarios reales 2026.' },
    @{ file='costo-estudiar-exterior-2026.html';                  title='Cuanto Cuesta Estudiar en el Exterior 2026: Guia Real para Colombianos | Navia Global';               desc='Costos reales de estudiar ingles en el exterior para colombianos: escuelas, visa, alojamiento y manutencion 2026.' },
    @{ file='alojamiento-estudiar-exterior-colombia.html';        title='Alojamiento para Estudiar en el Exterior 2026: Opciones y Costos | Navia Global';                      desc='Tipos de alojamiento para estudiantes en el exterior: homestay, residencias y pisos compartidos. Costos 2026.' },
    @{ file='becas-estudiar-exterior-colombia-2026.html';         title='Becas para Estudiar en el Exterior 2026: Guia para Colombianos | Navia Global';                        desc='Las mejores becas para colombianos en el exterior 2026: Fulbright, Daad, Icetex y oportunidades por pais.' },
    @{ file='diferencia-ielts-toefl-colombia.html';               title='IELTS vs TOEFL 2026: Cual Examen Elegir como Colombiano | Navia Global';                               desc='Diferencias entre IELTS y TOEFL para colombianos: cual piden Australia, Canada, UK y USA. Costos y preparacion.' },
    @{ file='ingles-b2-cuanto-tiempo-colombia.html';              title='Cuanto Tiempo para Lograr Ingles B2 desde Colombia 2026 | Navia Global';                               desc='Tiempo real para alcanzar nivel B2 de ingles desde cero en Colombia o en el exterior. Metodos y costos 2026.' },
    @{ file='maestrias-exterior-colombia-2026.html';              title='Maestrias en el Exterior 2026: Opciones y Costos para Colombianos | Navia Global';                     desc='Mejores destinos para hacer una maestria en el exterior: Australia, Canada, UK y Alemania para colombianos 2026.' },
    @{ file='como-elegir-escuela-idiomas-exterior.html';          title='Como Elegir una Escuela de Idiomas en el Exterior 2026 | Navia Global';                                desc='Guia para escoger la mejor escuela de ingles en el exterior: acreditaciones, ubicacion y costos. Navia Global.' },
    @{ file='como-conseguir-trabajo-extranjero-colombia.html';    title='Como Conseguir Trabajo en el Extranjero desde Colombia 2026 | Navia Global';                          desc='Pasos reales para conseguir trabajo en el extranjero siendo colombiano: visa, CV internacional y estrategias 2026.' },
    @{ file='estudiar-exterior-sin-dinero-colombia-2026.html';    title='Estudiar en el Exterior sin Dinero 2026: Es Posible para Colombianos | Navia Global';                  desc='Como financiar estudios en el exterior sin ahorros: becas, trabajo y prestamos. Opciones reales para colombianos 2026.' },
    @{ file='vivir-trabajar-irlanda-colombianos-2026.html';       title='Vivir y Trabajar en Irlanda 2026: Guia Completa para Colombianos | Navia Global';                      desc='Como vivir y trabajar en Irlanda como colombiano: visa, salario EUR 13.50/h, costos reales mayo 2026.' }
)

$ok = 0; $skip = 0; $notfound = 0

foreach ($u in $updates) {
    $path = Join-Path $base $u.file
    if (-not (Test-Path $path)) { $notfound++; Write-Host ("NOT FOUND: " + $u.file); continue }

    $c = [System.IO.File]::ReadAllText($path, $enc)
    $changed = $false

    $newTitle = '<title>' + $u.title + '</title>'
    $c2 = [System.Text.RegularExpressions.Regex]::Replace($c, '<title>[^<]*</title>', $newTitle)
    if ($c2 -ne $c) { $c = $c2; $changed = $true }

    $newDesc = '<meta name="description" content="' + $u.desc + '">'
    $c2 = [System.Text.RegularExpressions.Regex]::Replace($c, '<meta\s+name="description"\s+content="[^"]*"[^>]*>', $newDesc)
    if ($c2 -ne $c) { $c = $c2; $changed = $true }

    if ($changed) {
        [System.IO.File]::WriteAllText($path, $c, $enc)
        $ok++
        Write-Host ("OK: " + $u.file)
    } else {
        $skip++
        Write-Host ("SKIP: " + $u.file)
    }
}

Write-Host ("DONE - Updated: " + $ok + " | Skipped: " + $skip + " | Not found: " + $notfound)
