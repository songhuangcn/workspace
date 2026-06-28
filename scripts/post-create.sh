#!/usr/bin/env bash
set -euo pipefail

# 1) 校验 docker-in-docker feature 提供的本地 Docker daemon（由镜像 metadata 的 entrypoint 启动）。
if docker info >/dev/null 2>&1; then
  echo "Docker daemon 就绪（docker-in-docker feature）。"
else
  echo "警告：Docker daemon 暂未就绪（可能仍在启动），请稍后用 docker info 重试。"
fi

# 2) sshd 兜底启动（sshd feature 已装 openssh-server，正常会随容器启动）。
if ! pgrep -x sshd >/dev/null 2>&1; then
  sudo service ssh start 2>/dev/null || sudo /usr/sbin/sshd 2>/dev/null || true
fi

# 3) 公钥认证：~/.ssh 已从宿主机挂载，仅修正权限（不写宿主机文件，避免污染宿主机 ~/.ssh）。
chmod 700 ~/.ssh 2>/dev/null || true
[ -f ~/.ssh/authorized_keys ] && chmod 600 ~/.ssh/authorized_keys || true
echo "sshd 监听容器内 2222（未发布到宿主机）。其他应用连入前请确保 ~/.ssh/authorized_keys 含对应公钥。"
