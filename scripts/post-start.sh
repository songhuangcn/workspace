#!/usr/bin/env bash
set -euo pipefail

PORT="${OPENCODE_PORT:-4096}"
HOST="${OPENCODE_HOST:-0.0.0.0}"
LOG_FILE="${OPENCODE_LOG_FILE:-/tmp/opencode-web.log}"

if lsof -ti "tcp:${PORT}" >/dev/null 2>&1; then
  echo "opencode web already listening on ${PORT}."
  exit 0
fi

nohup opencode web --port "${PORT}" --hostname "${HOST}" >>"${LOG_FILE}" 2>&1 &
echo "opencode web started on ${HOST}:${PORT} (log: ${LOG_FILE})."
