#!/usr/bin/env bash
set -euo pipefail

PORT="${OPENCODE_PORT:-4096}"
HOST="${OPENCODE_HOST:-0.0.0.0}"
LOG_FILE="${OPENCODE_LOG_FILE:-/tmp/opencode-web.log}"

if lsof -ti "tcp:${PORT}" -sTCP:LISTEN >/dev/null 2>&1; then
  echo "opencode web already listening on ${PORT}."
  exit 0
fi

setsid -f opencode web --port "${PORT}" --hostname "${HOST}" >>"${LOG_FILE}" 2>&1 < /dev/null
sleep 1

if lsof -ti "tcp:${PORT}" -sTCP:LISTEN >/dev/null 2>&1; then
  echo "opencode web started on ${HOST}:${PORT} (log: ${LOG_FILE})."
  exit 0
fi

echo "opencode web failed to listen on ${HOST}:${PORT}; see ${LOG_FILE}." >&2
exit 1
