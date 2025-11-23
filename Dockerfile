# Usamos la imagen oficial ligera de n8n (Alpine)
FROM n8nio/n8n:latest

# Cambiamos a root para instalar paquetes del sistema
USER root

# 1. Instalar Chromium y dependencias necesarias para que arranque
# Usamos los repositorios de Alpine que son rápidos y seguros
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

# 2. Configurar Playwright para usar el Chromium instalado (NO descargar otro)
# Esto ahorra espacio y evita errores de compatibilidad
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium

# 3. Instalar la librería Playwright globalmente
RUN npm install -g playwright

# 4. Volver al usuario seguro 'node'
USER node
