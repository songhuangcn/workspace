#!/usr/bin/env bash
set -euo pipefail

echo "Fixing docker.sock permission..."
sudo chown ubuntu:ubuntu /var/run/docker.sock
