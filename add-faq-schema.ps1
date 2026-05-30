# Add FAQPage JSON-LD schema to all 10 landing pages

$pages = @{
  "australia" = @{
    url = "https://naviaglobal.co/australia/"
    faqs = @(
      @{ q = "Cuantas horas puede trabajar un estudiante en Australia"; a = "Los estudiantes internacionales en Australia pueden trabajar hasta 24 horas semanales durante el periodo lectivo y tiempo ilimitado en vacaciones. El salario minimo es de AUD 24.10 por hora." }
      @{ q = "Cuanto cuesta estudiar ingles en Australia desde Colombia"; a = "El costo promedio es entre AUD 300-500 por semana de curso, mas AUD 200-350 por semana en alojamiento compartido. El total mensual oscila entre 8M y 14M COP incluyendo manutencion." }
      @{ q = "Que visa necesito para estudiar en Australia siendo colombiano"; a = "Necesitas la visa de estudiante subclase 500. Cuesta AUD 710, requiere aceptacion en institucion registrada CRICOS, seguro OSHC y demostracion de fondos. En Navia Global te acompanamos en todo el proceso." }
      @{ q = "Cuanto tiempo demora el tramite de la visa de estudiante para Australia"; a = "El promedio actual es 4 a 6 semanas. Se recomienda iniciar el tramite con al menos 8 semanas de anticipacion a la fecha de inicio del curso." }
      @{ q = "Se puede quedar a vivir en Australia despues de estudiar"; a = "Si. Los graduados pueden aplicar al Graduate Temporary Visa subclase 485, que da hasta 4 anos de residencia temporal para trabajar. Despues se puede aplicar a residencia permanente por puntos mediante SkillSelect." }
    )
  }
  "irlanda" = @{
    url = "https://naviaglobal.co/irlanda/"
    faqs = @(
      @{ q = "Cuantas horas puede trabajar un estudiante en Irlanda"; a = "Los estudiantes en Irlanda con Stamp 2 pueden trabajar 20 horas semanales durante el curso y 40 horas por semana en vacaciones de junio a septiembre y diciembre a enero." }
      @{ q = "Que visa necesito para estudiar ingles en Irlanda siendo colombiano"; a = "Para cursos de menos de 3 meses puedes entrar como turista. Para cursos mas largos necesitas la visa de estudiante irlandesa Stamp 2, tramitada ante la embajada irlandesa con un costo de EUR 60 a 100." }
      @{ q = "Cuanto cuesta vivir estudiando en Irlanda"; a = "El costo mensual estimado es entre EUR 1.200 y 1.800, incluyendo alojamiento compartido EUR 600-900, comida EUR 300-400, transporte EUR 120 y ocio. Dubling es mas caro que Cork o Galway." }
      @{ q = "Es dificil encontrar trabajo siendo estudiante en Irlanda"; a = "No. Irlanda tiene una de las tasas de desempleo mas bajas de Europa. Los sectores mas comunes son hosteleria, retail y administracion. Con ingles basico-intermedio ya puedes acceder a empleos con salario minimo de EUR 13.50 por hora." }
      @{ q = "Puedo llevar a mi familia si estudio en Irlanda"; a = "Dependiendo de la duracion del curso y el tipo de permiso, puede ser posible para conyuge e hijos. En Navia Global evaluamos cada caso gratuitamente para darte la opcion mas conveniente." }
    )
  }
  "canada" = @{
    url = "https://naviaglobal.co/canada/"
    faqs = @(
      @{ q = "Cuantas horas puede trabajar un estudiante en Canada"; a = "Desde noviembre de 2022, los estudiantes internacionales en Canada pueden trabajar horas ilimitadas fuera del campus mientras sus clases estan activas, y sin limite tambien entre semestres." }
      @{ q = "Que es el Study Permit de Canada y como se tramita"; a = "Es el permiso de estudio canadiense, equivalente a la visa de estudiante. Se tramita en linea a traves de IRCC, cuesta CAD 150 y tiene un tiempo de aprobacion de 8 a 12 semanas en promedio para colombianos." }
      @{ q = "Cuanto cuesta vivir y estudiar en Canada desde Colombia"; a = "El costo mensual oscila entre CAD 2.000 y 3.500 dependiendo de la ciudad. Toronto y Vancouver son las mas costosas; Halifax, Calgary y Montreal son mas accesibles para estudiantes." }
      @{ q = "Puedo hacer la residencia permanente en Canada despues de estudiar"; a = "Si. Con el Post-Graduation Work Permit PGWP puedes trabajar 1 a 3 anos y acumular puntos para Express Entry o Provincial Nominee Programs, que son las principales vias a la residencia permanente." }
      @{ q = "Necesito IELTS para estudiar ingles en Canada"; a = "No siempre. Muchas escuelas de idiomas aceptan una prueba de nivel propia como requisito de admision. Para ingresar a college o universidad si se requiere IELTS 6.0 a 6.5 en promedio." }
    )
  }
  "malta" = @{
    url = "https://naviaglobal.co/malta/"
    faqs = @(
      @{ q = "Cuantas horas puede trabajar un estudiante en Malta"; a = "Los estudiantes en Malta con permiso de residencia pueden trabajar 20 horas semanales durante el periodo de clases. No hay restriccion de sector y muchos estudiantes trabajan en hosteleria, turismo y servicios." }
      @{ q = "Necesita visa Malta para colombianos"; a = "Si. Malta es parte del espacio Schengen. Los colombianos necesitan visa Schengen para estadias superiores a 90 dias. Para estudiar mas de 3 meses se requiere permiso de residencia maltes." }
      @{ q = "Por que elegir Malta para estudiar ingles"; a = "Malta ofrece clima mediterraneo, clases en ingles como primer idioma oficial, costos de vida mas bajos que Irlanda o UK, y la posibilidad de trabajar desde el primer dia de residencia. Es ideal para colombianos con presupuesto ajustado." }
      @{ q = "Cuanto cuesta estudiar ingles en Malta"; a = "El costo del curso es aproximadamente EUR 150 a 250 por semana. Sumando alojamiento EUR 400-600 por mes, comida y transporte, el total mensual ronda los EUR 900 a 1.400." }
      @{ q = "Es Malta un buen destino para mejorar el ingles rapido"; a = "Si. Al ser una isla angloparlante donde el ingles es idioma oficial, los estudiantes se ven forzados a usarlo fuera del aula. La inmersion total acelera el aprendizaje significativamente en comparacion con paises de habla no inglesa." }
    )
  }
  "dubai" = @{
    url = "https://naviaglobal.co/dubai/"
    faqs = @(
      @{ q = "Necesitan visa los colombianos para ir a Dubai"; a = "Para estadias cortas de turismo hasta 90 dias los colombianos pueden ingresar sin visa previa. Para estadias de estudio mas largas se tramita la student visa emiratí, con tiempos de aprobacion de 7 a 10 dias habiles." }
      @{ q = "Cuanto cuesta estudiar ingles en Dubai"; a = "El costo del curso de ingles en Dubai oscila entre USD 250 y 450 por semana. El alojamiento en habitacion compartida cuesta USD 400 a 700 por mes. El total mensual ronda USD 1.200 a 1.800." }
      @{ q = "Se puede trabajar mientras se estudia en Dubai"; a = "Las restricciones de trabajo varian segun el tipo de visa. Con visa de estudiante la posibilidad de trabajar es limitada. Sin embargo, Dubai es atractivo por su ambiente cosmopolita y networking internacional para el futuro profesional." }
      @{ q = "Por que estudiar en Dubai en lugar de Europa o Australia"; a = "Dubai ofrece visas muy rapidas en 7 dias, ambiente libre de impuestos, clima calido todo el ano, excelente calidad de institutos de idiomas y una red de contactos internacionales unica. Ideal para quienes buscan una experiencia diferente." }
      @{ q = "Que nivel de ingles se necesita para estudiar en Dubai"; a = "Las escuelas de idiomas en Dubai ofrecen todos los niveles, desde A1 hasta C1. No necesitas nivel previo para matricularte. El primer dia haras una prueba de clasificacion para ubicarte en el grupo correcto." }
    )
  }
  "nueva-zelanda" = @{
    url = "https://naviaglobal.co/nueva-zelanda/"
    faqs = @(
      @{ q = "Cuantas horas puede trabajar un estudiante en Nueva Zelanda"; a = "Los estudiantes internacionales en Nueva Zelanda con cursos de 14 o mas semanas pueden trabajar hasta 20 horas semanales durante el periodo lectivo y tiempo completo en vacaciones." }
      @{ q = "Que visa necesito para estudiar en Nueva Zelanda siendo colombiano"; a = "Necesitas la Student Visa de Nueva Zelanda, que se tramita en linea a traves de Immigration New Zealand. Cuesta NZD 375, requiere aceptacion en institucion registrada y fondos suficientes. El proceso demora 4 a 8 semanas." }
      @{ q = "Cuanto cuesta estudiar en Nueva Zelanda"; a = "Los cursos de ingles cuestan aproximadamente NZD 300 a 500 por semana. El alojamiento en homestay u habitacion compartida oscila entre NZD 250 a 400 por semana. El salario minimo es NZD 23.15 por hora." }
      @{ q = "Es Nueva Zelanda mejor que Australia para estudiar"; a = "Ambos son excelentes. Nueva Zelanda permite 20 horas por semana de trabajo, el costo de vida es ligeramente menor y los paisajes son unicos. Australia tiene mas ciudades y mas ofertas laborales en tecnologia y finanzas." }
      @{ q = "Se puede emigrar a Nueva Zelanda despues de estudiar"; a = "Si. Tras completar estudios se puede aplicar al Post Study Work Visa por hasta 3 anos, y luego a residencia permanente por puntos mediante el sistema Skilled Migrant. Nueva Zelanda es uno de los paises mas accesibles para emigrar." }
    )
  }
  "reino-unido" = @{
    url = "https://naviaglobal.co/reino-unido/"
    faqs = @(
      @{ q = "Cuantas horas puede trabajar un estudiante en el Reino Unido"; a = "Los estudiantes con Student Visa del Reino Unido pueden trabajar hasta 20 horas semanales durante el periodo lectivo. En vacaciones oficiales pueden trabajar tiempo completo." }
      @{ q = "Que visa necesitan los colombianos para estudiar en el Reino Unido"; a = "Los colombianos necesitan la Student Visa. Cuesta GBP 490 para estudios dentro del UK, requiere aceptacion en institucion licenciada por UKVI, seguro medico NHS IHS y fondos suficientes demostrables." }
      @{ q = "Cuanto cuesta estudiar ingles en Londres"; a = "Los cursos de ingles en Londres cuestan GBP 200 a 400 por semana. El alojamiento en habitacion compartida cuesta GBP 700 a 1.200 por mes. Manchester y otras ciudades son entre 20 y 35 por ciento mas baratas que Londres." }
      @{ q = "Se puede estudiar ingles en el Reino Unido por menos de 6 meses"; a = "Si. Para cursos de hasta 6 meses, los colombianos pueden ingresar como visitante con Standard Visitor Visa sin necesitar Student Visa. Esto simplifica el proceso y reduce costos de tramite." }
      @{ q = "El ingles britanico es mejor que el americano para el mercado laboral colombiano"; a = "Ambos son igualmente validos y reconocidos. El ingles britanico tiene mayor prestigio en Europa y es el estandar en muchas multinacionales con sede en Colombia. El acento y vocabulario se adaptan rapidamente al entorno laboral." }
    )
  }
  "estados-unidos" = @{
    url = "https://naviaglobal.co/estados-unidos/"
    faqs = @(
      @{ q = "Que visa necesita un colombiano para estudiar en Estados Unidos"; a = "Para cursos de idiomas de mas de 18 horas semanales se requiere la visa F-1. Para cursos recreativos cortos puede aplicar la visa de turista B-2. La visa F-1 cuesta USD 160 en consulado mas USD 350 de SEVIS." }
      @{ q = "Puede trabajar un estudiante con visa F-1 en Estados Unidos"; a = "Si, pero con restricciones. Los estudiantes F-1 pueden trabajar hasta 20 horas semanales en el campus de su institucion durante el semestre. En vacaciones pueden trabajar fuera del campus con autorizacion especial CPT u OPT." }
      @{ q = "Cuanto cuesta estudiar ingles en Estados Unidos"; a = "El costo del curso oscila entre USD 300 y 600 por semana dependiendo de la ciudad y la escuela. El alojamiento en homestay cuesta USD 800 a 1.400 por mes. Nueva York y San Francisco son las mas costosas." }
      @{ q = "Es dificil obtener la visa F-1 para colombianos"; a = "La tasa de aprobacion varia segun el perfil y la entrevista. Se recomienda demostrar vinculos fuertes con Colombia, fondos suficientes y carta de aceptacion de la institucion. Navia Global te prepara para la entrevista consular." }
      @{ q = "Cual es la mejor ciudad de Estados Unidos para aprender ingles"; a = "Nueva York y Miami para entorno cosmopolita; Boston para ambiente universitario; Los Angeles para clima y entretenimiento. Para colombianos, Miami tiene la ventaja de la comunidad hispanohablante, aunque puede reducir la inmersion en ingles." }
    )
  }
  "francia" = @{
    url = "https://naviaglobal.co/francia/"
    faqs = @(
      @{ q = "Necesitan visa los colombianos para estudiar en Francia"; a = "Si. Los colombianos necesitan visa de larga duracion VLS-TS etudiant para cursos de mas de 90 dias. La visa se tramita ante la embajada francesa en Colombia o a traves de Campus France. El costo es EUR 99." }
      @{ q = "Se puede estudiar frances e ingles al mismo tiempo en Francia"; a = "Si. Muchas escuelas en Paris y otras ciudades ofrecen programas combinados o cursos intensivos de ambos idiomas. Tambien existen programas en ingles dictados en Francia para internacionales." }
      @{ q = "Cuanto cuesta estudiar en Paris"; a = "Paris es una de las ciudades mas costosas de Europa. El alojamiento en habitacion compartida cuesta EUR 700 a 1.200 por mes. Ciudades como Lyon, Montpellier o Burdeos son entre 20 y 40 por ciento mas baratas con excelente calidad de vida." }
      @{ q = "Puede trabajar un estudiante en Francia"; a = "Si. Los estudiantes con visa de larga duracion VLS-TS pueden trabajar hasta 964 horas anuales, aproximadamente 20 horas por semana. El salario minimo en Francia es EUR 11.88 por hora segun el SMIC 2025." }
      @{ q = "Vale la pena aprender frances para colombianos"; a = "Absolutamente. El frances es el tercer idioma de negocios en el mundo, habilitante en 29 paises de Africa, clave para organizaciones internacionales como ONU, UNESCO y Cruz Roja, y muy valorado en el sector diplomatico y cooperacion internacional." }
    )
  }
  "alemania" = @{
    url = "https://naviaglobal.co/alemania/"
    faqs = @(
      @{ q = "Es gratis estudiar en Alemania siendo colombiano"; a = "Las universidades publicas alemanas no cobran matricula para pregrado y posgrado, pero si hay una tarifa semestral de EUR 150 a 350 para transporte y servicios estudiantiles. Se necesita demostrar fondos de EUR 11.208 anuales en una cuenta bloqueada Sperrkonto." }
      @{ q = "Que visa se necesita para estudiar en Alemania"; a = "Para estudios de idiomas Sprachkurs de mas de 90 dias necesitas visa nacional tipo D de Alemania. Para estudios universitarios, la visa de estudiante Studienvisum. Ambas se tramitan en la embajada alemana en Colombia." }
      @{ q = "Se puede estudiar en Alemania en ingles sin saber aleman"; a = "Si. Alemania tiene mas de 1.500 programas de maestria en ingles. Para pregrado en universidades publicas generalmente se requiere aleman B2, pero muchas escuelas de idiomas y programas de preparacion funcionan completamente en ingles." }
      @{ q = "Cuanto cuesta vivir en Alemania siendo estudiante"; a = "El presupuesto mensual estimado es EUR 800 a 1.200 incluyendo habitacion en residencia EUR 300-500, comida EUR 200-250, transporte EUR 80-100 con semesterticket y otros gastos. Berlin y Munich son mas caras que ciudades medianas como Leipzig o Bremen." }
      @{ q = "Puedo quedarme a trabajar en Alemania despues de estudiar"; a = "Si. Los graduados de universidades alemanas reconocidas pueden solicitar el permiso de busqueda de empleo por 18 meses. Con contrato accedes a residencia de trabajo y eventualmente a la residencia permanente Niederlassungserlaubnis." }
    )
  }
}

foreach ($dest in $pages.Keys) {
    $data = $pages[$dest]
    $filePath = "C:\Users\User\.claude\navia-website\$dest\index.html"

    $faqItems = @()
    foreach ($faq in $data.faqs) {
        $q = $faq.q -replace '"', '&quot;'
        $a = $faq.a -replace '"', '&quot;'
        $faqItems += "{`"@type`":`"Question`",`"name`":`"$q`",`"acceptedAnswer`":{`"@type`":`"Answer`",`"text`":`"$a`"}}"
    }
    $faqJson = $faqItems -join ","

    $schema = "<script type=`"application/ld+json`">`n{`"@context`":`"https://schema.org`",`"@type`":`"FAQPage`",`"mainEntity`":[$faqJson]}`n</script>"

    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

    if ($content -notmatch "FAQPage") {
        $newContent = $content.Replace("</head>", "$schema`n</head>")
        [System.IO.File]::WriteAllText($filePath, $newContent, [System.Text.Encoding]::UTF8)
        Write-Host "OK $dest"
    } else {
        Write-Host "SKIP $dest (already has FAQPage)"
    }
}
