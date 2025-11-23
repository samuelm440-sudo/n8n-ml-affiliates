FROM n8nio/n8n:latest

USER root

# 1. Instalar Chromium y dependencias del sistema (Alpine)
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

# 2. Configurar Playwright para usar el Chromium del sistema
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium

# 3. Instalar Playwright globalmente
RUN npm install -g playwright

# 4. ¡ESTA ES LA LÍNEA QUE FALTABA! 
# Le dice a Node.js dónde buscar los módulos globales
ENV NODE_PATH=/usr/local/lib/node_modules

USER node
