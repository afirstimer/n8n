# n8n >= 2.1.0 không còn apk trong image gốc – copy tạm từ Alpine để cài ffmpeg
# https://github.com/n8n-io/n8n/issues/23246
FROM alpine:3.23 AS alpine

FROM n8nio/n8n:latest

COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/

USER root

RUN apk add --no-cache ffmpeg \
 && rm -f /sbin/apk /usr/lib/libapk.so*

USER node
