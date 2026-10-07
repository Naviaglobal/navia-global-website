# -*- coding: utf-8 -*-
"""
Regenera el bloque estatico de requisitos oficiales dentro de index.html
a partir de data/requisitos.json.

Para que existe: la calculadora esconde su resultado detras del formulario,
asi que Google y los buscadores con IA no ven ninguna cifra. Este bloque
publica lo que YA es publico y oficial -- fondos de visa, horas de trabajo
y salario minimo, con su fuente -- para que la pagina tenga contenido real
que indexar. No publica nada del calculo personalizado ni precios de Navia.

Uso:  python build-tabla.py
Correr cada vez que cambie requisitos.json.
"""
import io, json, os, re, sys

sys.stdout.reconfigure(encoding='utf-8')
AQUI = os.path.dirname(os.path.abspath(__file__))
INICIO = '<!-- TABLA-REQUISITOS:inicio (generado por build-tabla.py, no editar a mano) -->'
FIN = '<!-- TABLA-REQUISITOS:fin -->'

MES = ['enero','febrero','marzo','abril','mayo','junio',
       'julio','agosto','septiembre','octubre','noviembre','diciembre']

def fecha_larga(iso):
    p = (iso or '').split('-')
    return '%d de %s de %s' % (int(p[2]), MES[int(p[1]) - 1], p[0]) if len(p) == 3 else iso

def miles(n):
    return format(int(n), ',').replace(',', '.')

def celda_fondos(d):
    f = d.get('fondos_visa') or {}
    m = d['moneda']
    if f.get('valor_oficial') is not None:
        return '%s %s<small>cifra oficial para cursos de 8 meses o menos</small>' % (m, miles(f['valor_oficial']))
    if f.get('valor_mensual_londres') is not None:
        return ('%s %s/mes en Londres · %s %s/mes fuera<small>máximo %s meses</small>'
                % (m, miles(f['valor_mensual_londres']), m, miles(f['valor_mensual_fuera']),
                   f.get('meses_maximo', 9)))
    if f.get('valor') is not None:
        return '%s %s<small>al año</small>' % (m, miles(f['valor']))
    return '<span class="ca-pend">Por verificar</span>'

def celda_horas(d):
    h = d.get('horas_trabajo') or {}
    if h.get('sin_limite'):
        return 'Sin límite'
    if h.get('en_clases') is None:
        return '<span class="ca-pend">Por verificar</span>'
    txt = '%s h/semana' % h['en_clases']
    cond = h.get('condicion')
    if h.get('en_vacaciones'):
        cond = '%s h en vacaciones. %s' % (h['en_vacaciones'], cond or '')
    return txt + ('<small>%s</small>' % cond.strip() if cond else '')

def celda_salario(d):
    s = d.get('salario_minimo') or {}
    if s.get('valor') is None:
        return '<span class="ca-pend">Por verificar</span>'
    extra = s.get('jurisdiccion') or ''
    return '%s %s/hora%s' % (d['moneda'], str(s['valor']).replace('.', ','),
                             '<small>%s</small>' % extra if extra else '')

def main():
    req = json.load(io.open(os.path.join(AQUI, 'data', 'requisitos.json'), encoding='utf-8'))
    verif = fecha_larga(req['_meta']['generado'])

    filas = []
    for slug, d in req['destinos'].items():
        f = d.get('fondos_visa') or {}
        fuente = f.get('fuente_url')
        enlace = ('<a href="%s" target="_blank" rel="noopener nofollow">%s</a>'
                  % (fuente, f.get('fuente', 'Fuente oficial'))) if fuente else '—'
        filas.append(
            '<tr><th scope="row"><a href="/%s/">%s</a></th><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>'
            % (slug, d['nombre'], celda_fondos(d), celda_horas(d), celda_salario(d), enlace))

    html = (INICIO + '''
  <section class="ca-panel" id="caRequisitos" aria-labelledby="caHReq">
    <h2 id="caHReq">Lo que exige cada país para la visa de estudiante en 2026</h2>
    <p class="ca-hint" style="margin:0">Cifras oficiales de inmigración, verificadas al ''' + verif + '''. La prueba de fondos es el dinero que tienes que demostrar disponible al aplicar: no cuenta lo que planees ganar trabajando. Confirma siempre en la fuente oficial antes de radicar.</p>
    <div class="ca-tablewrap">
      <table class="ca-req">
        <caption class="ca-hint">Prueba de fondos, horas de trabajo permitidas y salario mínimo por destino</caption>
        <thead><tr><th scope="col">Destino</th><th scope="col">Prueba de fondos</th><th scope="col">Trabajo en clases</th><th scope="col">Salario mínimo</th><th scope="col">Fuente</th></tr></thead>
        <tbody>
''' + '\n'.join('        ' + f for f in filas) + '''
        </tbody>
      </table>
    </div>
    <p class="ca-hint" style="margin:0">Los montos están en la moneda de cada país. Para verlos en pesos colombianos y sumarles matrícula, vida, tiquetes y seguro, usa la calculadora de arriba.</p>
  </section>
  ''' + FIN)

    p = os.path.join(AQUI, 'index.html')
    s = io.open(p, encoding='utf-8').read()
    if INICIO in s:
        s = re.sub(re.escape(INICIO) + '.*?' + re.escape(FIN), lambda m: html, s, flags=re.S)
        accion = 'actualizado'
    else:
        ancla = '  <section class="ca-panel ca-faq" aria-labelledby="caHFaq">'
        assert ancla in s, 'no encontre donde insertar la tabla'
        s = s.replace(ancla, html + '\n\n' + ancla, 1)
        accion = 'insertado'
    io.open(p, 'w', encoding='utf-8', newline='').write(s)
    print('bloque %s · %d destinos · verificado al %s' % (accion, len(filas), verif))

if __name__ == '__main__':
    main()
