# Dockerfile para n8n con Playwright (Optimizado para Alpine)

# 1. Usar la imagen base oficial de n8n
FROM n8nio/n8n

# --- Instalación de Playwright y sus dependencias ---

# 2. Instalar las dependencias del sistema requeridas por Playwright (usando apk para Alpine)
# Estas librerías son esenciales para que los navegadores headless funcionen.
RUN apk update \
    && apk add --no-cache \
    udev \
    ttf-freefont \
    libstdc++ \
    nss \
    mesa-gl \
    chromium \
    # Limpiar caché después de instalar
    && rm -rf /var/cache/apk/*

# 3. Establecer un directorio de trabajo temporal para la instalación de Playwright
# Esto evita el error "Unsupported URL Type 'workspace:'"
WORKDIR /tmp/playwright_install

# 4. Inicializar un nuevo proyecto simple y instalar la librería 'playwright'
RUN npm init -y \
    && npm install playwright \
    && npx playwright install --with-deps

# 5. Mover los módulos instalados a la ubicación global de Node.js
# Esto hace que Playwright esté disponible a través de 'require('playwright')' en el nodo Code de n8n.
RUN mv node_modules/playwright /usr/local/lib/node_modules/playwright

# 6. Limpiar el directorio temporal y volver al directorio de trabajo original de n8n
RUN rm -rf /tmp/playwright_install
WORKDIR /usr/local/lib/node_modules/n8n

# --- Tu Configuración Original ---

# 7. Exponer el puerto de n8n
EXPOSE 5678

# 8. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
