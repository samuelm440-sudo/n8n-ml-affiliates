# Dockerfile para n8n con Playwright (VERSIÓN 7: Corrección Final)

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
RUN npm install -g playwright

# 5. Instalar los navegadores binarios de Playwright
RUN npx playwright install

# 6. Establecer el directorio de trabajo predeterminado de n8n
WORKDIR /usr/local/lib/node_modules/n8n

# 7. **¡LA SOLUCIÓN!** Agregar el path global de Node.js a NODE_PATH
# Esto asegura que el proceso de n8n pueda encontrar el módulo 'playwright'
ENV NODE_PATH=/usr/local/lib/node_modules

# 8. Volver al usuario predeterminado de n8n
USER node 

# --- Configuración de n8n ---

# 9. Exponer el puerto de n8n
EXPOSE 5678

# 10. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
