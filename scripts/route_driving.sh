#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER="$(${SCRIPT_DIR}/resolve_server.sh)"

ORIGIN=""
DESTINATION=""
WAYPOINTS=""

usage() {
  cat <<USAGE
用法:
  scripts/route_driving.sh --origin "120.1,30.2" --destination "120.3,30.4" [--waypoints "120.2,30.3;120.25,30.35"]
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --origin) ORIGIN="${2:-}"; shift 2 ;;
    --destination) DESTINATION="${2:-}"; shift 2 ;;
    --waypoints) WAYPOINTS="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "[route_driving] unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "${ORIGIN}" || -z "${DESTINATION}" ]]; then
  echo "[route_driving] --origin/--destination 必填。" >&2
  usage
  exit 1
fi

ORI_JSON="$(jq -Rn --arg v "${ORIGIN}" '$v')"
DST_JSON="$(jq -Rn --arg v "${DESTINATION}" '$v')"
CALL="${SERVER}.maps_direction_driving(origin: ${ORI_JSON}, destination: ${DST_JSON}"
if [[ -n "${WAYPOINTS}" ]]; then
  WP_JSON="$(jq -Rn --arg v "${WAYPOINTS}" '$v')"
  CALL+=" , waypoints: ${WP_JSON}"
fi
CALL+=")"

"${SCRIPT_DIR}/mcp.sh" call "${CALL}" --output json
