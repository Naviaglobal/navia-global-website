"""Genera el reporte de pago de CuántoAfuera a partir de los datos de un estudiante.

Uso: python3 generar_reporte.py   (usa el perfil de ejemplo de abajo)
Para un cliente real, cambia el diccionario PERFIL y vuelve a correrlo.
"""
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import mm
from reportlab.lib import colors
from reportlab.lib.styles import ParagraphStyle
from reportlab.platypus import (SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle,
                                PageBreak, KeepTogether)
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

FONT_DIR = "/usr/share/fonts/truetype/dejavu/"
pdfmetrics.registerFont(TTFont("Body", FONT_DIR + "DejaVuSans.ttf"))
pdfmetrics.registerFont(TTFont("Bold", FONT_DIR + "DejaVuSans-Bold.ttf"))
from reportlab.lib.fonts import addMapping
pdfmetrics.registerFontFamily("Body", normal="Body", bold="Bold", italic="Body", boldItalic="Bold")
pdfmetrics.registerFont(TTFont("Mono", FONT_DIR + "DejaVuSansMono.ttf"))

ACCENT = colors.HexColor("#0E6B5C")
SOFT = colors.HexColor("#E0EFEB")
INK = colors.HexColor("#16201E")
MUTED = colors.HexColor("#5B6966")
LINE = colors.HexColor("#D6DEDB")
WARN = colors.HexColor("#FBEFD9")

FECHA_VERIFICACION = "7 de octubre de 2026"

# ---------- Requisitos oficiales (verificados al 7 oct 2026) ----------
PAISES = {
    "ca": dict(nombre="Canadá", mon="CAD", fx=2410, visa=150, vida_mes=1954, matricula_ref=18000,
               fondos=lambda m, t: t + 23448,
               regla="Matrícula 1er año + CAD 23.448 de vida (desde 1 sep 2026, fuera de Quebec) + tiquetes"),
    "uk": dict(nombre="Reino Unido", mon="GBP", fx=4430, visa=558, vida_mes=1171, matricula_ref=18000,
               extra=lambda m: -(-m // 12) * 776,
               fondos=lambda m, t: t + 1171 * min(m, 9),
               regla="Matrícula 1er año + £1.171/mes fuera de Londres, máx. 9 meses (sube a £1.203 el 30 nov 2026)"),
    "ie": dict(nombre="Irlanda", mon="EUR", fx=3840, visa=100, vida_mes=833, matricula_ref=14000,
               fondos=lambda m, t: t + (833 * m if m < 8 else 10000),
               regla="Matrícula pagada + €10.000 de vida por año (€833/mes si dura menos de 8 meses)"),
    "au": dict(nombre="Australia", mon="AUD", fx=2180, visa=2500, vida_mes=2476, matricula_ref=30000,
               fondos=lambda m, t: t + round(29710 * min(m, 12) / 12) + 2000,
               regla="Matrícula 1er año + AUD 29.710 por 12 meses de vida + viaje"),
    "nz": dict(nombre="Nueva Zelanda", mon="NZD", fx=1950, visa=950, vida_mes=1667, matricula_ref=25000,
               fondos=lambda m, t: t + (1667 * m if m < 12 else 20000),
               regla="Matrícula + NZD 20.000 de vida por año (NZD 1.667/mes si dura menos de un año)"),
}


# ---------- Trabajo durante los estudios (verificado al 7 oct 2026 salvo "verificar") ----------
TRABAJO = {
    "ca": dict(salario=17.95, sal_lbl="CAD 17,95/h (mínimo Ontario desde 1 oct 2026)",
               horas=lambda t, m: 0 if t == "ingles" else 24,
               nota="24 h/semana en clases, ilimitado en vacaciones. Cursos de inglés (ESL) sin permiso de trabajo."),
    "uk": dict(salario=12.71, sal_lbl="£12,71/h aprox. (verificar)",
               horas=lambda t, m: 0 if t == "ingles" else (10 if t == "tecnico" else 20),
               nota="20 h/semana en grado o superior, 10 h por debajo de grado. Inglés independiente: sin trabajo."),
    "ie": dict(salario=14.15, sal_lbl="€14,15/h (mínimo desde ene 2026)",
               horas=lambda t, m: 20,
               nota="20 h/semana en clases; 40 h del 1 jun al 30 sep y del 15 dic al 15 ene. Inglés ILEP 25+ semanas incluido."),
    "au": dict(salario=26.44, sal_lbl="AUD 26,44/h (mínimo desde 1 jul 2026)",
               horas=lambda t, m: 24,
               nota="48 h cada dos semanas en clases; ilimitado en vacaciones."),
    "nz": dict(salario=23.15, sal_lbl="NZD 23,15/h aprox. (verificar)",
               horas=lambda t, m: 0 if (t == "ingles" and m < 4) else 25,
               nota="25 h/semana en clases; tiempo completo en vacaciones. Inglés: 14+ semanas con proveedor Categoría 1."),
}
TIPO_LBL = {"ingles": "Curso de inglés", "tecnico": "College / técnico", "pregrado": "Pregrado", "maestria": "Maestría"}


def ingreso_posible(pais, tipo, meses, horas_plan):
    """Supuesto conservador: sin trabajo los 2 primeros meses, 75 % del tiempo en clases, 15 % de descuentos."""
    t = TRABAJO[pais]
    legal = t["horas"](tipo, meses)
    h = min(horas_plan, legal)
    return h, legal, h * t["salario"] * 4.33 * max(0, meses - 2) * 0.75 * 0.85

MATRICULA_REF = {  # matrícula anual aproximada por tipo de programa, moneda local
    "ca": dict(ingles=16000, tecnico=18000, pregrado=36000, maestria=30000),
    "uk": dict(ingles=12000, tecnico=12000, pregrado=22000, maestria=22000),
    "ie": dict(ingles=5000, tecnico=9000, pregrado=16000, maestria=17000),
    "au": dict(ingles=20000, tecnico=15000, pregrado=40000, maestria=42000),
    "nz": dict(ingles=18000, tecnico=22000, pregrado=35000, maestria=35000),
}

# ---------- Perfil del estudiante (EJEMPLO) ----------
PERFIL = dict(
    nombre="Laura Gómez (ejemplo)",
    pais="ca",
    ciudad="Toronto, Ontario",
    programa="College, diploma de 2 años en Business Administration",
    tipo="tecnico",
    horas_trabajo=15,               # horas/semana que planea trabajar
    meses=24,
    matricula_anual=18000,          # en moneda del destino
    tiquetes=4_500_000,             # COP
    seguro=3_500_000,               # COP por año
    colchon=0.10,
    ahorro_actual=20_000_000,       # COP
    meses_para_ahorrar=8,           # hasta reunir la prueba de fondos
    inicio_ahorro="noviembre 2026",
)


def cop(n):
    return "$" + f"{round(n):,}".replace(",", ".")


def loc(n, mon):
    return f"{round(n):,}".replace(",", ".") + " " + mon


def costo_total(p, meses, matricula_total, tiquetes, seguro_anual, colchon):
    anios = -(-meses // 12)
    fx = p["fx"]
    filas = [
        ("Matrícula", matricula_total * fx),
        (f"Vida ({meses} meses)", p["vida_mes"] * meses * fx),
        ("Visa", p["visa"] * fx),
    ]
    if "extra" in p:
        filas.append(("Recargo de salud (IHS)", p["extra"](meses) * fx))
    filas += [("Tiquetes", tiquetes), (f"Seguro médico ({anios} año{'s' if anios > 1 else ''})", seguro_anual * anios)]
    sub = sum(v for _, v in filas)
    if colchon:
        filas.append((f"Colchón de imprevistos {round(colchon*100)} %", sub * colchon))
    return filas, sum(v for _, v in filas)


# ---------- Estilos ----------
S = dict(
    h1=ParagraphStyle("h1", fontName="Bold", fontSize=22, leading=27, textColor=INK, spaceAfter=4),
    h2=ParagraphStyle("h2", fontName="Bold", fontSize=14, leading=18, textColor=ACCENT, spaceBefore=10, spaceAfter=6),
    body=ParagraphStyle("body", fontName="Body", fontSize=9.5, leading=14, textColor=INK),
    small=ParagraphStyle("small", fontName="Body", fontSize=8, leading=11, textColor=MUTED),
    big=ParagraphStyle("big", fontName="Bold", fontSize=26, leading=30, textColor=INK),
    label=ParagraphStyle("label", fontName="Bold", fontSize=8, leading=10, textColor=MUTED),
    brand=ParagraphStyle("brand", fontName="Bold", fontSize=11, textColor=ACCENT),
    cell=ParagraphStyle("cell", fontName="Body", fontSize=8.8, leading=12, textColor=INK),
    cellb=ParagraphStyle("cellb", fontName="Bold", fontSize=8.8, leading=12, textColor=INK),
)


def tabla(datos, anchos, num_cols=(), cabecera=True, total=False):
    t = Table(datos, colWidths=anchos, hAlign="LEFT")
    est = [
        ("FONT", (0, 0), (-1, -1), "Body", 8.8),
        ("TEXTCOLOR", (0, 0), (-1, -1), INK),
        ("LINEBELOW", (0, 0), (-1, -1), 0.4, LINE),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
        ("TOPPADDING", (0, 0), (-1, -1), 5),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
    ]
    for c in num_cols:
        est += [("ALIGN", (c, 0), (c, -1), "RIGHT"), ("FONT", (c, 1 if cabecera else 0), (c, -1), "Mono", 8.8)]
    if cabecera:
        est += [("FONT", (0, 0), (-1, 0), "Bold", 8), ("TEXTCOLOR", (0, 0), (-1, 0), MUTED),
                ("LINEBELOW", (0, 0), (-1, 0), 0.8, INK)]
    if total:
        est += [("FONT", (0, -1), (-1, -1), "Bold", 9.5), ("BACKGROUND", (0, -1), (-1, -1), SOFT),
                ("LINEABOVE", (0, -1), (-1, -1), 0.8, INK)]
    t.setStyle(TableStyle(est))
    return t


def caja(contenido, fondo=SOFT, ancho=170 * mm):
    t = Table([[contenido]], colWidths=[ancho])
    t.setStyle(TableStyle([("BACKGROUND", (0, 0), (-1, -1), fondo), ("LEFTPADDING", (0, 0), (-1, -1), 10),
                           ("RIGHTPADDING", (0, 0), (-1, -1), 10), ("TOPPADDING", (0, 0), (-1, -1), 8),
                           ("BOTTOMPADDING", (0, 0), (-1, -1), 8)]))
    return t


def pie(canvas, doc):
    canvas.saveState()
    canvas.setFont("Body", 7.5)
    canvas.setFillColor(MUTED)
    canvas.drawString(20 * mm, 12 * mm,
                      f"CuántoAfuera · una herramienta de Navia Global Education S.A.S. · NIT 902.003.125-8 · "
                      f"Cifras verificadas al {FECHA_VERIFICACION}")
    canvas.drawRightString(196 * mm, 12 * mm, f"{doc.page}")
    canvas.setStrokeColor(ACCENT)
    canvas.setLineWidth(3)
    canvas.line(20 * mm, 272 * mm, 40 * mm, 272 * mm)
    canvas.restoreState()


def construir(perfil, salida):
    p = PAISES[perfil["pais"]]
    mon = p["mon"]
    meses = perfil["meses"]
    matricula_total = perfil["matricula_anual"] * (meses / 12)
    filas, total = costo_total(p, meses, matricula_total, perfil["tiquetes"], perfil["seguro"], perfil["colchon"])
    fondos_loc = p["fondos"](meses, perfil["matricula_anual"])
    fondos_cop = fondos_loc * p["fx"] + perfil["tiquetes"]
    falta = max(0, fondos_cop - perfil["ahorro_actual"])
    cuota = falta / perfil["meses_para_ahorrar"]

    st = []
    # ---- Página 1: resumen ----
    st += [Paragraph("CuántoAfuera", S["brand"]), Spacer(1, 6),
           Paragraph("Tu presupuesto para estudiar afuera", S["h1"]),
           Paragraph(f"{perfil['nombre']} · {perfil['programa']} · {perfil['ciudad']}, {p['nombre']}", S["body"]),
           Spacer(1, 14)]
    resumen = Table([
        [Paragraph("COSTO TOTAL ESTIMADO", S["label"]), Paragraph("FONDOS QUE EXIGE LA VISA", S["label"]),
         Paragraph("AHORRO MENSUAL NECESARIO", S["label"])],
        [Paragraph(cop(total), ParagraphStyle("b1", parent=S["big"], fontSize=17, leading=21)),
         Paragraph(cop(fondos_cop), ParagraphStyle("b2", parent=S["big"], fontSize=17, leading=21)),
         Paragraph(cop(cuota), ParagraphStyle("b3", parent=S["big"], fontSize=17, leading=21, textColor=ACCENT))],
        [Paragraph(f"{meses} meses, todo incluido", S["small"]),
         Paragraph(f"{loc(fondos_loc, mon)} + tiquetes", S["small"]),
         Paragraph(f"durante {perfil['meses_para_ahorrar']} meses", S["small"])],
    ], colWidths=[57 * mm] * 3, hAlign="LEFT")
    resumen.setStyle(TableStyle([("BOX", (0, 0), (-1, -1), 0.6, LINE), ("INNERGRID", (0, 0), (-1, -1), 0, colors.white),
                                 ("LINEAFTER", (0, 0), (1, -1), 0.6, LINE), ("LEFTPADDING", (0, 0), (-1, -1), 9),
                                 ("TOPPADDING", (0, 0), (-1, -1), 4), ("BOTTOMPADDING", (0, 0), (-1, -1), 4)]))
    st += [resumen, Spacer(1, 14), Paragraph("Desglose del costo total", S["h2"])]
    datos = [["Concepto", "Valor en COP"]] + [[c, cop(v)] for c, v in filas] + [["Total", cop(total)]]
    st += [tabla(datos, [120 * mm, 50 * mm], num_cols=(1,), total=True), Spacer(1, 8),
           Paragraph(f"Tasa usada: 1 {mon} = {cop(p['fx'])} COP. Vida mensual de referencia: {loc(p['vida_mes'], mon)}. "
                     f"Matrícula: {loc(perfil['matricula_anual'], mon)} por año.", S["small"]),
           Spacer(1, 10)]
    st.append(caja(Paragraph(
        f"<b>Regla de fondos para {p['nombre']}:</b> {p['regla']}. "
        "Este es el mínimo que debes demostrar al aplicar; el costo real de vivir suele ser mayor.", S["body"])))
    h, legal, ing = ingreso_posible(perfil["pais"], perfil["tipo"], meses, perfil["horas_trabajo"])
    ing_cop = ing * p["fx"]
    tr = TRABAJO[perfil["pais"]]
    st += [Spacer(1, 6), Paragraph("Ingreso posible trabajando", S["h2"])]
    filas_w = [["Concepto", "Valor"],
               ["Horas por semana (plan / máximo legal)", f"{h} / {legal}"],
               ["Salario de referencia", tr["sal_lbl"]],
               ["Ingreso neto posible en el programa", cop(ing_cop)],
               ["Costo neto de tu bolsillo", cop(max(0, total - ing_cop))]]
    st += [tabla(filas_w, [90 * mm, 80 * mm], num_cols=(1,), total=True), Spacer(1, 6),
           Paragraph(f"{tr['nota']} Supuesto conservador: sin trabajo los 2 primeros meses, solo periodos de clase, "
                     "15 % de descuentos. <b>Este ingreso no cuenta para la prueba de fondos de la visa.</b>", S["small"])]
    st.append(PageBreak())

    # ---- Página 2: comparativo ----
    st += [Paragraph("Comparativo de 5 destinos", S["h2"]),
           Paragraph("Programa de 12 meses del mismo tipo en cada país, con los mismos tiquetes, seguro y colchón de tu plan. "
                     "Sirve para comparar órdenes de magnitud; la matrícula real depende del programa.", S["body"]),
           Spacer(1, 8)]
    comp = [["Destino", "Matrícula ref.", "Fondos visa", "Costo 12 meses", "Trabajo", "Costo neto"]]
    orden = []
    for k, q in PAISES.items():
        mref = MATRICULA_REF[k][perfil["tipo"]]
        _, tot = costo_total(q, 12, mref, perfil["tiquetes"], perfil["seguro"], perfil["colchon"])
        fv = q["fondos"](12, mref) * q["fx"]
        hh, lg, ii = ingreso_posible(k, perfil["tipo"], 12, perfil["horas_trabajo"])
        neto = max(0, tot - ii * q["fx"])
        orden.append((neto, q["nombre"], loc(mref, q["mon"]), cop(fv), cop(tot), f"{lg} h/sem" if lg else "No", cop(neto)))
    orden.sort()
    comp += [list(r[1:]) for r in orden]
    st += [tabla(comp, [27 * mm, 27 * mm, 30 * mm, 30 * mm, 21 * mm, 35 * mm], num_cols=(1, 2, 3, 5)), Spacer(1, 4),
           Paragraph(f"Tipo de programa comparado: {TIPO_LBL[perfil['tipo']]}. Costo neto con {perfil['horas_trabajo']} h/semana "
                     "de trabajo (o el máximo legal si es menor), con el supuesto conservador. Ordenado de menor a mayor costo neto.",
                     S["small"]), Spacer(1, 10)]
    st.append(caja(Paragraph(
        "<b>Cómo leer esta tabla:</b> la columna de fondos es lo que debes demostrar antes de viajar, y ahí el trabajo "
        "no cuenta. El costo neto muestra cuánto sale de tu bolsillo si trabajas lo planeado. Un país más caro de "
        "entrada puede quedar más barato si permite trabajar más horas o paga mejor.", S["body"])))
    st += [Spacer(1, 14), Paragraph("Fondos y trabajo en cada país", S["h2"])]
    reglas = [["País", "Fondos para la visa", "Trabajo permitido"]] + [
        [q["nombre"], Paragraph(q["regla"], S["cell"]), Paragraph(TRABAJO[k]["nota"], S["cell"])] for k, q in PAISES.items()]
    st += [tabla(reglas, [28 * mm, 72 * mm, 70 * mm])]
    st.append(PageBreak())

    # ---- Página 3: plan de ahorro ----
    st += [Paragraph("Tu plan de ahorro mes a mes", S["h2"]),
           Paragraph(f"Meta: reunir {cop(fondos_cop)} para la prueba de fondos. Ya tienes {cop(perfil['ahorro_actual'])}; "
                     f"te faltan {cop(falta)}. Empezando en {perfil['inicio_ahorro']}, necesitas ahorrar "
                     f"<b>{cop(cuota)} al mes</b> durante {perfil['meses_para_ahorrar']} meses.", S["body"]),
           Spacer(1, 10)]
    plan = [["Mes", "Ahorro del mes", "Acumulado", "% de la meta"]]
    acum = perfil["ahorro_actual"]
    for i in range(1, perfil["meses_para_ahorrar"] + 1):
        acum += cuota
        plan.append([f"Mes {i}", cop(cuota), cop(acum), f"{min(100, acum / fondos_cop * 100):.0f} %"])
    st += [tabla(plan, [30 * mm, 45 * mm, 50 * mm, 45 * mm], num_cols=(1, 2, 3)), Spacer(1, 12)]
    st.append(caja(Paragraph(
        "<b>Antes de aplicar:</b> IRCC revisa cuánto dinero tienes y también de dónde viene. Un depósito grande y "
        "reciente sin explicación es una causa común de rechazo. Ahorra en una sola cuenta, guarda los soportes de cada "
        "ingreso (nómina, venta de un bien, préstamo) y evita mover el dinero entre cuentas en los meses previos.",
        S["body"]), fondo=WARN))
    st += [Spacer(1, 10), Paragraph(
        "Alternativas si la cuota es muy alta: pagar por adelantado la matrícula del primer año (reduce lo que debes "
        "mostrar en cuenta, aunque no el costo total), un crédito educativo con carta de aprobación, o el patrocinio de "
        "tus padres con soportes de sus ingresos.", S["body"])]
    st.append(PageBreak())

    # ---- Página 4: checklist ----
    st += [Paragraph(f"Checklist de prueba de fondos · {p['nombre']}", S["h2"]),
           Paragraph("Marca cada documento cuando lo tengas. Los documentos en español deben ir con traducción oficial "
                     "al inglés o al francés.", S["body"]), Spacer(1, 8)]
    items = [
        ("Extractos bancarios de los últimos 4 meses", "En tu nombre o del patrocinador, con sello o firma del banco."),
        ("Certificación bancaria con saldo actual", "Reciente, en papel membreteado del banco."),
        ("Recibo de pago de matrícula (si ya pagaste)", "Emitido por la institución en Canadá."),
        ("Carta de aprobación de crédito educativo", "Solo si financias con banco o ICETEX."),
        ("Certificado de inversión garantizada (GIC)", "Opcional; lo emiten bancos canadienses participantes."),
        ("Carta de patrocinio firmada", "Si tus padres u otra persona pagan: relación contigo y monto que aportan."),
        ("Soportes de ingresos del patrocinador", "Certificado laboral, desprendibles de nómina o declaración de renta."),
        ("Explicación del origen de los fondos", "Una carta corta que explique depósitos grandes o recientes."),
        ("Traducciones oficiales", "De todo documento que no esté en inglés o francés."),
        ("Carta de aceptación y PAL/TAL", "Verifica si tu programa requiere la carta de la provincia."),
    ]
    chk = [[Paragraph("☐", S["cellb"]), Paragraph(f"<b>{a}</b><br/><font color='#5B6966'>{b}</font>", S["cell"])]
           for a, b in items]
    t = Table(chk, colWidths=[8 * mm, 162 * mm], hAlign="LEFT")
    t.setStyle(TableStyle([("LINEBELOW", (0, 0), (-1, -1), 0.4, LINE), ("VALIGN", (0, 0), (-1, -1), "TOP"),
                           ("TOPPADDING", (0, 0), (-1, -1), 5), ("BOTTOMPADDING", (0, 0), (-1, -1), 5)]))
    st += [t, Spacer(1, 14)]
    st.append(KeepTogether([
        Paragraph("¿Quieres que revisemos tu caso?", S["h2"]),
        Paragraph("El equipo de Navia Global Education te ayuda a elegir programa, armar la prueba de fondos y preparar "
                  "la visa. Escríbenos por WhatsApp al <b>+57 301 443 0722</b>. Primera conversación sin costo.", S["body"]),
    ]))
    st += [Spacer(1, 14), Paragraph(
        f"<b>Fuentes y aviso.</b> Requisitos de fondos verificados al {FECHA_VERIFICACION} en publicaciones de IRCC "
        "(Canadá), GOV.UK / Home Office (Reino Unido), Immigration Service Delivery (Irlanda), Home Affairs (Australia) "
        "e Immigration New Zealand. Las tasas de cambio son de referencia. Este reporte es informativo, no constituye "
        "asesoría migratoria y no garantiza la aprobación de una visa. Confirma siempre los requisitos en el sitio "
        "oficial antes de aplicar.", S["small"])]

    doc = SimpleDocTemplate(salida, pagesize=letter, leftMargin=20 * mm, rightMargin=20 * mm,
                            topMargin=18 * mm, bottomMargin=20 * mm,
                            title="Presupuesto CuántoAfuera", author="Navia Global Education S.A.S.")
    doc.build(st, onFirstPage=pie, onLaterPages=pie)


if __name__ == "__main__":
    import sys
    construir(PERFIL, sys.argv[1] if len(sys.argv) > 1 else "reporte-ejemplo-canada.pdf")
