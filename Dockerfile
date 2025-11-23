# 1. Usar la imagen oficial de n8n (Basada en Alpine Linux)
FROM n8nio/n8n:latest

USER root

# 2. Instalar Chromium y dependencias del sistema
# En Alpine usamos 'apk' en lugar de 'apt-get'
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

# 3. Variables de entorno CRÍTICAS para Playwright en Alpine
# Le decimos a Playwright: "No descargues tu navegador, usa el que acabo de instalar"
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium

# 4. Instalar Playwright globalmente
RUN npm install -g playwright

# 5. Volver al usuario node por seguridad
USER node
