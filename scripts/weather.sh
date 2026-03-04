#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER="$(${SCRIPT_DIR}/resolve_server.sh)"

CITY=""
EXT="base"

usage() {
  cat <<USAGE
用法:
  scripts/weather.sh --city "330100|杭州" [--extensions base|all]
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --city) CITY="${2:-}"; shift 2 ;;
    --extensions) EXT="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "[weather] unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "${CITY}" ]]; then
  echo "[weather] --city 必填。" >&2
  usage
  exit 1
fi

if [[ "${EXT}" != "base" && "${EXT}" != "all" ]]; then
  echo "[weather] --extensions 仅支持 base/all。" >&2
  exit 1
fi

CITY_JSON="$(jq -Rn --arg v "${CITY}" '$v')"
EXT_JSON="$(jq -Rn --arg v "${EXT}" '$v')"
"${SCRIPT_DIR}/mcp.sh" call "${SERVER}.maps_weather(city: ${CITY_JSON}, extensions: ${EXT_JSON})" --output json
