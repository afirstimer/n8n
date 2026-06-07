FROM n8nio/n8n:latest

USER root

# Hỗ trợ cả image Alpine (apk) và Debian (apt) của n8n
RUN if command -v apk > /dev/null; then \
      apk add --no-cache ffmpeg; \
    elif command -v apt-get > /dev/null; then \
      apt-get update && \
      apt-get install -y --no-install-recommends ffmpeg && \
      rm -rf /var/lib/apt/lists/*; \
    else \
      echo "Unsupported base image: cannot install ffmpeg" && exit 1; \
    fi

USER node
