#!/usr/bin/env bash
# Phapsuit – cài Docker + FFmpeg trên Ubuntu VPS (22.04 / 24.04)
# Chạy: sudo bash scripts/setup-ubuntu-vps.sh

set -euo pipefail

if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "Chạy script với quyền root: sudo bash $0"
  exit 1
fi

echo "==> Cập nhật package..."
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release ffmpeg

echo "==> Kiểm tra FFmpeg..."
ffmpeg -version | head -n 1

if ! command -v docker > /dev/null; then
  echo "==> Cài Docker..."
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc

  CODENAME="$(. /etc/os-release && echo "${VERSION_CODENAME}")"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
    > /etc/apt/sources.list.d/docker.list

  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
  echo "==> Docker đã có sẵn, bỏ qua cài đặt."
fi

systemctl enable docker
systemctl start docker

echo "==> Kiểm tra Docker Compose..."
docker compose version

echo ""
echo "Hoàn tất. Tiếp theo trên VPS:"
echo "  1. Clone/copy repo phapsuit-stack vào thư mục deploy"
echo "  2. cp .env.example .env && chỉnh secret"
echo "  3. docker compose build && docker compose up -d"
echo "  4. Kiểm tra FFmpeg trong n8n: docker compose exec n8n ffmpeg -version"
