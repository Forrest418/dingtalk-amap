#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER="$(${SCRIPT_DIR}/resolve_server.sh)"

CITY=""
CITYD=""
ORIGIN=""
DESTINATION=""

usage() {
  cat <<USAGE
用法:
  scripts/route_transit.sh --city "杭州" --origin "120.1,30.2" --destination "120.3,30.4" [--cityd "上海"]
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --city) CITY="${2:-}"; shift 2 ;;
    --cityd) CITYD="${2:-}"; shift 2 ;;
    --origin) ORIGIN="${2:-}"; shift 2 ;;
    --destination) DESTINATION="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "[route_transit] unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "${CITY}" || -z "${ORIGIN}" || -z "${DESTINATION}" ]]; then
  echo "[route_transit] --city/--origin/--destination 必填。" >&2
  usage
  exit 1
fi

CITY_JSON="$(jq -Rn --arg v "${CITY}" '$v')"
ORI_JSON="$(jq -Rn --arg v "${ORIGIN}" '$v')"
DST_JSON="$(jq -Rn --arg v "${DESTINATION}" '$v')"
CALL="${SERVER}.maps_direction_transit_integrated(city: ${CITY_JSON}, origin: ${ORI_JSON}, destination: ${DST_JSON}"
if [[ -n "${CITYD}" ]]; then
  CITYD_JSON="$(jq -Rn --arg v "${CITYD}" '$v')"
  CALL+=" , cityd: ${CITYD_JSON}"
fi
CALL+=")"

"${SCRIPT_DIR}/mcp.sh" call "${CALL}" --output json
