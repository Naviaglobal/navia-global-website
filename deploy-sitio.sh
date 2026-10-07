#!/usr/bin/env bash
# Despliega TODO naviaglobal.co a produccion.
#   bash deploy-sitio.sh --dry   -> solo lista
#   bash deploy-sitio.sh         -> despliega
# NO uses deploy-vercel.ps1 ni deploy-fix.ps1: solo mandan blog/*.html e
# index.html, y como el deploy reemplaza el sitio entero, borran destinos,
# calculadora, comparador, CSS, imagenes y sitemaps.
set -uo pipefail

BASE="$(cd "$(dirname "$0")" && pwd)"
TEAM="team_XYsFDYqhJk3U1rmm9ejyhvnY"
PROYECTO="navia-website"
API="https://api.vercel.com"
DRY=0
[ "${1:-}" = "--dry" ] && DRY=1

TK="${VERCEL_TOKEN:-}"
if [ -z "$TK" ]; then
  TK="$(powershell.exe -NoProfile -Command "[Environment]::GetEnvironmentVariable('VERCEL_TOKEN','User')" 2>/dev/null | tr -d '\r\n')"
fi
[ -n "$TK" ] || { echo "ERROR: falta VERCEL_TOKEN" >&2; exit 2; }
AUTH="Authorization: Bearer $TK"
cd "$BASE"

LISTA="$(find . -type f \
  -not -path './.git/*' -not -path './node_modules/*' -not -path './.vercel/*' \
  -not -path './.claude/*' -not -path './_carru/*' -not -path './_reelfix/*' \
  -not -path './_reel_src/*' -not -path './_sep/*' -not -path './_sep2/*' \
  -not -path './lp/*' -not -path './cuantoafuera/reporte/*' \
  -not -name '*.ps1' -not -name '*.py' -not -name '*.sh' -not -name '*.md' \
  -not -name '*.mp4' -not -name 'tpl-*.html' \
  -not -name 'package.json' -not -name 'package-lock.json' \
  -not -name '.gitignore' -not -name '.gitattributes' -not -name '.vercelignore' \
  | sed 's|^\./||' | sort)"

N="$(printf '%s\n' "$LISTA" | grep -c .)"
echo "Archivos a publicar: $N"
if [ "$DRY" = "1" ]; then
  printf '%s\n' "$LISTA" | sed 's/^/  /'
  echo "(simulacion: no se subio nada)"
  exit 0
fi

FILES=""; SUBIDOS=0
while IFS= read -r f; do
  [ -n "$f" ] || continue
  sha="$(sha1sum "$f" | cut -d' ' -f1)"
  size="$(stat -c%s "$f")"
  code="$(curl -s -o /dev/null -w '%{http_code}' -X POST "$API/v2/files?teamId=$TEAM" \
          -H "$AUTH" -H "x-vercel-digest: $sha" -H "Content-Type: application/octet-stream" \
          --data-binary @"$f")"
  case "$code" in
    200|201|409) SUBIDOS=$((SUBIDOS+1)) ;;
    *) echo "ERROR subiendo $f: HTTP $code" >&2; exit 5 ;;
  esac
  FILES="$FILES{\"file\":\"$f\",\"sha\":\"$sha\",\"size\":$size},"
done <<< "$LISTA"
FILES="[${FILES%,}]"
echo "Subidos: $SUBIDOS de $N"

RESP="$(curl -s -X POST "$API/v13/deployments?teamId=$TEAM&skipAutoDetectionConfirmation=1" \
  -H "$AUTH" -H "Content-Type: application/json" \
  -d "{\"name\":\"$PROYECTO\",\"target\":\"production\",\"files\":$FILES,\"projectSettings\":{\"framework\":null}}")"
ID="$(printf '%s' "$RESP" | grep -o '"id":"dpl_[^"]*"' | head -1 | cut -d'"' -f4)"
[ -n "$ID" ] || { echo "ERROR creando el deploy: $(printf '%s' "$RESP" | grep -o '"message":"[^"]*"' | head -1)" >&2; exit 6; }
echo "Deployment: $ID"

STATE=""
for i in $(seq 1 60); do
  ST="$(curl -s "$API/v13/deployments/$ID?teamId=$TEAM" -H "$AUTH")"
  STATE="$(printf '%s' "$ST" | grep -o '"readyState":"[A-Z]*"' | head -1 | cut -d'"' -f4)"
  [ "$STATE" = "READY" ] && break
  [ "$STATE" = "ERROR" ] && { echo "ERROR: el deploy fallo" >&2; exit 7; }
  sleep 4
done
[ "$STATE" = "READY" ] || { echo "ERROR: no quedo listo (estado: $STATE)" >&2; exit 8; }
echo "READY. Revisa https://naviaglobal.co/"