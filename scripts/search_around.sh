#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER="$(${SCRIPT_DIR}/resolve_server.sh)"

LOCATION=""
KEYWORDS=""
RADIUS="5000"

usage() {
  cat <<USAGE
用法:
  scripts/search_around.sh --location "120.153576,30.287459" --keywords "咖啡" [--radius 3000]
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --location) LOCATION="${2:-}"; shift 2 ;;
    --keywords) KEYWORDS="${2:-}"; shift 2 ;;
    --radius) RADIUS="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "[search_around] unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "${LOCATION}" || -z "${KEYWORDS}" ]]; then
  echo "[search_around] --location/--keywords 必填。" >&2
  usage
  exit 1
fi

LOC_JSON="$(jq -Rn --arg v "${LOCATION}" '$v')"
KEY_JSON="$(jq -Rn --arg v "${KEYWORDS}" '$v')"
RAD_JSON="$(jq -Rn --arg v "${RADIUS}" '$v')"
"${SCRIPT_DIR}/mcp.sh" call "${SERVER}.maps_search_around(location: ${LOC_JSON}, keywords: ${KEY_JSON}, radius: ${RAD_JSON})" --output json
