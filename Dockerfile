FROM n8nio/n8n:latest

# Instalar Chromium Browser y dependencias en Alpine Linux
RUN apk add --no-cache \
    chromium \
    nss \
    atk \
    at-spi2-atk \
    cups-libs \
    libxkbcommon \
    libxcomposite \
    libxdamage \
    libxrandr \
    libgbm \
    alsa-lib \
    && rm -rf /var/cache/apk/*

# Configuración de Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_LAUNCH_OPTIONS='{"args":["--no-sandbox","--disable-setuid-sandbox","--disable-dev-shm-usage","--disable-gpu","--single-process"]}'

EXPOSE 5678
CMD ["node", "packages/cli/dist/index.js"]
