FROM n8nio/n8n:latest

# Instalar Chromium y dependencias mínimas para Puppeteer en Render
RUN apt-get update && \
    apt-get install -y \
    chromium \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Configuración de Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_LAUNCH_OPTIONS='{"args":["--no-sandbox","--disable-setuid-sandbox","--disable-dev-shm-usage","--disable-gpu","--single-process"]}'

# Puerto y comando
EXPOSE 5678
CMD ["node", "packages/cli/dist/index.js"]
