# Etapa 1: Construcción con n8n
FROM n8nio/n8n:latest AS n8n

# Etapa 2: Agregar Chromium desde una imagen confiable
FROM zenika/alpine-chrome:128 AS chrome

# Etapa final: Combinar n8n + Chromium
FROM n8nio/n8n:latest

# Copiar Chromium desde zenika/alpine-chrome
COPY --from=chrome /usr/bin/chromium /usr/bin/chromium
COPY --from=chrome /usr/lib/chromium /usr/lib/chromium

# Instalar dependencias de Chromium (Alpine)
RUN apk add --no-cache \
    nss \
    atk \
    at-spi2-atk \
    cups-libs \
    libxkbcommon \
    libxcomposite \
    libxdamage \
    libxrandr \
    libgbm \
    alsa-lib

# Configuración de Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_LAUNCH_OPTIONS='{"args":["--no-sandbox","--disable-setuid-sandbox","--disable-dev-shm-usage","--disable-gpu","--single-process","--disable-features=site-per-process"]}'

EXPOSE 5678
CMD ["node", "packages/cli/dist/index.js"]
