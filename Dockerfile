FROM n8nio/n8n:latest

# Instalar curl para health checks
USER root
RUN apk update && apk add --no-cache curl
USER node

EXPOSE 5678

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1
