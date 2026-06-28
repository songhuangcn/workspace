#!/usr/bin/env bash
set -euo pipefail

# 暂时不依赖 docker service，按需使用 docker 时再检查 dind 连接状态。
# echo "DOCKER_HOST=${DOCKER_HOST:-unset}"
# if docker info >/dev/null 2>&1; then
#   echo "已连接 dind daemon。"
# else
#   echo "警告：暂未连上 dind daemon（可能仍在启动），请稍后用 docker info 重试。"
# fi
