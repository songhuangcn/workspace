#!/usr/bin/env bash
set -euo pipefail

# docker daemon 由 dind 旁车提供，经 DOCKER_HOST=tcp://docker:2375 访问，无本地 socket。
echo "DOCKER_HOST=${DOCKER_HOST:-unset}"
if docker info >/dev/null 2>&1; then
  echo "已连接 dind daemon。"
else
  echo "警告：暂未连上 dind daemon（可能仍在启动），请稍后用 docker info 重试。"
fi
