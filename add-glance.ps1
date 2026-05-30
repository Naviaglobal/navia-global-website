$enc = New-Object System.Text.UTF8Encoding($false)
$blogDir = "C:\Users\User\.claude\navia-website\blog"

# At-a-glance data per article (filename -> [stat1, stat2, stat3, stat4])
$glanceData = @{
    "estudiar-australia-colombia-2026.html"    = @("Trabajo: 24h/sem","Salario: AUD `$24.95/h","Visa: 4-6 semanas","PGWP: 2-4 anos")
    "estudiar-irlanda-colombia-2026.html"      = @("Trabajo: 20h/sem","Salario: EUR 13.50/h","Visa Stamp 2","Graduate Route: 2 anos")
    "estudiar-canada-colombia-2026.html"       = @("Trabajo: 20h/sem","Salario: CAD `$17/h","Study Permit","PGWP: hasta 3 anos")
    "estudiar-nueva-zelanda-colombia-2026.html"= @("Trabajo: 25h/sem","Salario: NZD `$23.15/h","Visa: 4-8 semanas","Green List PR")
    "estudiar-reino-unido-colombia-2026.html"  = @("Trabajo: 20h/sem","Salario: GBP 12.71/h","Student Visa","Graduate Route: 2 anos")
    "estudiar-malta-colombia-2026.html"        = @("Trabajo: 20h/sem","Salario: EUR 8.50/h","Visa: 4 semanas","26 paises Schengen")
    "estudiar-dubai-colombia-2026.html"        = @("Trabajo: 48h/sem","Sin impuestos","Visa: 7 dias","Salario: AED 45/h")
    "estudiar-estados-unidos-colombia-2026.html"= @("Visa F-1: 8 dias","Salario: USD 15+/h","OPT: hasta 3 anos","Prestigio #1 mundial")
    "estudiar-alemania-colombia-2026.html"     = @("Estudio gratuito","Trabajo: 20h/sem","Salario: EUR 12.82/h","Post-estudio: 18 meses")
    "estudiar-francia-colombia-2026.html"      = @("Trabajo: 20h/sem","Salario: EUR 11.65/h","Visa campus France","Ciudad: Paris")
    "visa-estudiante-australia-2026.html"      = @("Subcl. 500","Costo: AUD 710","Tramite: 4-6 sem","GTE obligatorio")
    "visa-estudiante-irlanda-colombia-2026.html"= @("Stamp 2","Costo: EUR 300","Tramite: 4-8 sem","Renovable")
    "visa-estudiante-canada-2026.html"         = @("Study Permit","Costo: CAD 150","Tramite: 4-12 sem","LMIA exempto")
    "visa-estudiante-nueva-zelanda-colombia-2026.html"= @("Student Visa","Costo: NZD 330","Tramite: 4-8 sem","Dependientes OK")
    "visa-estudiante-reino-unido-colombia-2026.html"  = @("Student Visa","Costo: GBP 363","CAS obligatorio","IHS: GBP 776/ano")
    "visa-estudiante-malta-colombia-2026.html"  = @("Visa D / Schengen","Costo: aprox EUR 100","Tramite: 4 sem","26 paises libres")
    "visa-estudiante-dubai-colombia-2026.html"  = @("Visa estudiante UAE","Costo: AED 350+","Tramite: 7 dias","Renovable faci")
    "visa-estudiante-estados-unidos-colombia-2026.html"= @("Visa F-1","Entrevista: embajada","SEVIS: USD 350","Tramite: 3-8 sem")
    "australia-vs-canada-colombianos-2026.html" = @("Ganador trabajo: AU","Ganador costo: CA","Clima: similar","PGWP: AU gana")
    "australia-vs-irlanda-colombianos-2026.html"= @("Trabajo: AU 24h vs IE 20h","Salario: AU gana","Europa: IE gana","Visa: IE mas rapida")
    "canada-vs-reino-unido-colombianos-2026.html"= @("PGWP: CA 3 anos","Graduate: UK 2 anos","Trabajo: CA 20h","Costo: similar")
    "malta-vs-irlanda-colombianos-2026.html"    = @("Costo: Malta gana","Europa: ambos","Trabajo: IE gana","Clima: Malta gana")
    "trabajar-mientras-estudias-exterior.html"  = @("AU: 24h/sem","IE: 20h/sem","UK: 20h/sem","NZ: 25h/sem")
    "costo-estudiar-exterior-2026.html"         = @("Mas economico: Malta","Mejor ROI: Australia","Inversion min: USD 8K","Recuperacion: 6 meses")
    "becas-estudiar-exterior-colombia-2026.html"= @("Chevening UK","Australia Awards","DAAD Alemania","Fulbright USA")
    "diferencia-ielts-toefl-colombia.html"      = @("IELTS: 0-9 bands","TOEFL: 0-120 pts","Para UK/AU: IELTS","Para USA: TOEFL/IELTS")
}

$processed = 0

foreach ($filename in $glanceData.Keys) {
    $fpath = Join-Path $blogDir $filename
    if (-not (Test-Path $fpath)) { Write-Host ("[SKIP] $filename not found"); continue }

    $html = [System.IO.File]::ReadAllText($fpath, [System.Text.Encoding]::UTF8)

    # Skip if already has glance box
    if ($html -like "*at-a-glance*") { Write-Host ("[SKIP] $filename already has glance"); continue }

    $stats = $glanceData[$filename]
    $s1 = $stats[0]; $s2 = $stats[1]; $s3 = $stats[2]; $s4 = $stats[3]

    $glanceBox = @"
<div id="at-a-glance" style="background:linear-gradient(135deg,#0F2447,#1B4B8C);border-radius:16px;padding:22px 28px;margin:32px 0;color:white;display:grid;grid-template-columns:repeat(auto-fit,minmax(140px,1fr));gap:16px;align-items:center;"><div style="grid-column:1/-1;font-family:'Segoe UI',sans-serif;font-size:0.7rem;font-weight:800;letter-spacing:.12em;text-transform:uppercase;color:#32B298;margin-bottom:4px;">Datos Clave 2026</div><div style="text-align:center;"><div style="font-size:1.05rem;font-weight:800;color:white;line-height:1.3;">$s1</div></div><div style="text-align:center;"><div style="font-size:1.05rem;font-weight:800;color:white;line-height:1.3;">$s2</div></div><div style="text-align:center;"><div style="font-size:1.05rem;font-weight:800;color:white;line-height:1.3;">$s3</div></div><div style="text-align:center;"><div style="font-size:1.05rem;font-weight:800;color:white;line-height:1.3;">$s4</div></div></div>
"@

    # Inject after the expert verification box (after first .content div) or before .toc
    # Look for the toc block and inject before it
    if ($html -like "*class=`"toc`"*") {
        $html = $html -replace '(<div class="toc")', ($glanceBox + '$1')
    } elseif ($html -like "*class=`"blog-toc`"*") {
        $html = $html -replace '(<div class="blog-toc")', ($glanceBox + '$1')
    } else {
        # Fallback: inject after first </div> inside .container
        $html = $html -replace '(<!-- Tabla de Contenido -->)', ($glanceBox + '$1')
    }

    [System.IO.File]::WriteAllText($fpath, $html, $enc)
    $processed++
    Write-Host ("[OK] $filename")
}

Write-Host "`nAt-a-glance added to $processed articles"
