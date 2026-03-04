#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER="$(${SCRIPT_DIR}/resolve_server.sh)"

ADDRESS=""
CITY=""

usage() {
  cat <<USAGE
用法:
  scripts/geocode.sh --address "杭州西湖" [--city "杭州"]
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --address) ADDRESS="${2:-}"; shift 2 ;;
    --city) CITY="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "[geocode] unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "${ADDRESS}" ]]; then
  echo "[geocode] --address 必填。" >&2
  usage
  exit 1
fi

ADDRESS_JSON="$(jq -Rn --arg v "${ADDRESS}" '$v')"
CALL="${SERVER}.maps_geo(address: ${ADDRESS_JSON}"
if [[ -n "${CITY}" ]]; then
  CITY_JSON="$(jq -Rn --arg v "${CITY}" '$v')"
  CALL+=" , city: ${CITY_JSON}"
fi
CALL+=")"

"${SCRIPT_DIR}/mcp.sh" call "${CALL}" --output json
