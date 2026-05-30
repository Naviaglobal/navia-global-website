$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\User\.claude\navia-website\index.html"
$html = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$override = @'

        /* ===== TESTIMONIOS FIX + CALC AESTHETIC ===== */

        /* --- Testimonios: legibilidad --- */
        .testimonios-section {
            background: #F0F4FF !important;
        }
        .testimonio-card {
            background: #FFFFFF !important;
            border: 1px solid #D6E4FF !important;
            border-radius: 16px !important;
            box-shadow: 0 4px 16px rgba(27,75,140,0.08) !important;
            padding: 24px !important;
        }
        .testimonio-texto {
            color: #2C3E50 !important;
            font-size: 0.95rem !important;
            line-height: 1.65 !important;
        }
        .testimonio-stars {
            color: #F59E0B !important;
            font-size: 1.1rem !important;
        }
        .testimonio-autor strong {
            color: #1B4B8C !important;
            font-weight: 700 !important;
        }
        .testimonio-autor span,
        .testimonio-autor {
            color: #6B7280 !important;
            font-size: 0.85rem !important;
        }
        .testimonio-badge {
            background: #E8F0FE !important;
            color: #1B4B8C !important;
        }

        /* --- Calculadora: estetica --- */
        .calculadora-section,
        #calculadora {
            background: linear-gradient(135deg, #0A2463 0%, #1B4B8C 100%) !important;
        }
        .calculadora-section .section-title,
        #calculadora .section-title,
        .calc-title {
            color: #FFFFFF !important;
        }
        .calculadora-section .section-subtitle,
        #calculadora .section-subtitle {
            color: rgba(255,255,255,0.8) !important;
        }
        .calc-container {
            background: #FFFFFF !important;
            border-radius: 20px !important;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2) !important;
            padding: 32px !important;
            max-width: 700px !important;
            margin: 0 auto !important;
        }
        .calc-container label,
        .calc-label {
            color: #1B4B8C !important;
            font-weight: 700 !important;
            font-size: 0.85rem !important;
            text-transform: uppercase !important;
            letter-spacing: 0.05em !important;
            margin-bottom: 6px !important;
            display: block !important;
        }
        .calc-container select,
        #calc-destino, #calc-duracion, #calc-intensidad {
            width: 100% !important;
            padding: 12px 16px !important;
            border: 2px solid #D6E4FF !important;
            border-radius: 10px !important;
            font-size: 0.95rem !important;
            color: #2C3E50 !important;
            background: #F8FAFF !important;
            appearance: auto !important;
            margin-bottom: 16px !important;
            transition: border-color 0.2s !important;
            cursor: pointer !important;
        }
        .calc-container select:focus,
        #calc-destino:focus, #calc-duracion:focus, #calc-intensidad:focus {
            border-color: #1B4B8C !important;
            outline: none !important;
            background: #FFFFFF !important;
        }
        .calc-btn,
        button[onclick*="calcularPrograma"] {
            background: linear-gradient(135deg, #1ABC9C, #16A085) !important;
            color: #FFFFFF !important;
            border: none !important;
            border-radius: 50px !important;
            padding: 16px 40px !important;
            font-size: 1rem !important;
            font-weight: 700 !important;
            cursor: pointer !important;
            width: 100% !important;
            letter-spacing: 0.03em !important;
            box-shadow: 0 6px 20px rgba(26,188,156,0.35) !important;
            transition: transform 0.15s, box-shadow 0.15s !important;
            margin-top: 4px !important;
        }
        .calc-btn:hover,
        button[onclick*="calcularPrograma"]:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 10px 28px rgba(26,188,156,0.45) !important;
        }
        .calc-result {
            background: linear-gradient(135deg, #F0FDF9, #E8FDF5) !important;
            border: 2px solid #1ABC9C !important;
            border-radius: 16px !important;
            padding: 24px !important;
            margin-top: 20px !important;
        }
        #precio-total {
            font-size: 2.2rem !important;
            font-weight: 900 !important;
            color: #0A2463 !important;
            display: block !important;
            margin-bottom: 12px !important;
        }
        #calc-detalles {
            color: #374151 !important;
            font-size: 0.9rem !important;
            line-height: 1.8 !important;
        }
        #calc-detalles strong {
            color: #1B4B8C !important;
        }
        .calc-form-group {
            margin-bottom: 4px !important;
        }
'@

# Limpiar version anterior si existe
$html = [regex]::Replace($html, '(?s)/\* ===== TESTIMONIOS FIX \+ CALC AESTHETIC =====.*?(?=</style>)', '')

$lastStyle = $html.LastIndexOf('</style>')
$html = $html.Substring(0, $lastStyle) + $override + "`n        " + $html.Substring($lastStyle)

[System.IO.File]::WriteAllText($path, $html, $enc)
Write-Host "[OK] Testimonios legibilidad + Calculadora estetica aplicadas"
