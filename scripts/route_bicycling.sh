#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER="$(${SCRIPT_DIR}/resolve_server.sh)"

ORIGIN=""
DESTINATION=""

usage() {
  cat <<USAGE
用法:
  scripts/route_bicycling.sh --origin "120.1,30.2" --destination "120.3,30.4"
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --origin) ORIGIN="${2:-}"; shift 2 ;;
    --destination) DESTINATION="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "[route_bicycling] unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "${ORIGIN}" || -z "${DESTINATION}" ]]; then
  echo "[route_bicycling] --origin/--destination 必填。" >&2
  usage
  exit 1
fi

ORI_JSON="$(jq -Rn --arg v "${ORIGIN}" '$v')"
DST_JSON="$(jq -Rn --arg v "${DESTINATION}" '$v')"
"${SCRIPT_DIR}/mcp.sh" call "${SERVER}.maps_direction_bicycling(origin: ${ORI_JSON}, destination: ${DST_JSON})" --output json
