# Dockerfile para n8n con Playwright (VERSIÓN 6: Instalación Global)

# 1. Usar la imagen base oficial de n8n
FROM n8nio/n8n

# --- Instalación de Playwright (Requiere Root) ---

# 2. Cambiar temporalmente a usuario root para obtener permisos de instalación
USER root

# 3. Instalar las dependencias del sistema requeridas por Playwright (apk)
RUN apk update \
    && apk add --no-cache \
    udev \
    ttf-freefont \
    libstdc++ \
    nss \
    mesa-gl \
    chromium \
    && rm -rf /var/cache/apk/*

# 4. Instalar la librería 'playwright' de forma global
# La instalación global pone el módulo en /usr/local/lib/node_modules/playwright
RUN npm install -g playwright

# 5. Instalar los navegadores binarios de Playwright
# npx playwright install asume que la librería está en el path global.
RUN npx playwright install

# 6. Establecer el directorio de trabajo predeterminado de n8n y volver al usuario node
# WORKDIR debe estar DESPUÉS de la instalación global para evitar el conflicto de package.json.
WORKDIR /usr/local/lib/node_modules/n8n
USER node 

# --- Configuración de n8n ---

# 7. Exponer el puerto de n8n
EXPOSE 5678

# 8. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
