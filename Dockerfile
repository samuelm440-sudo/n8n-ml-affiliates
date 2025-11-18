# Dockerfile para n8n con Playwright (VERSIÓN FINAL)

# 1. Usar la imagen base oficial de n8n
FROM n8nio/n8n

# --- Instalación de Playwright (Requiere Root) ---

# 2. Cambiar temporalmente a usuario root para obtener permisos de instalación
USER root

# 3. Instalar las dependencias del sistema requeridas por Playwright (apk)
# Estas fueron instaladas correctamente en la ejecución anterior.
RUN apk update \
    && apk add --no-cache \
    udev \
    ttf-freefont \
    libstdc++ \
    nss \
    mesa-gl \
    chromium \
    && rm -rf /var/cache/apk/*

# 4. Instalar la librería 'playwright' y sus navegadores
# Ejecutamos la instalación de NPM y los binarios de los navegadores como root, 
# pero quitamos --with-deps para evitar que ejecute 'apt-get'.
RUN npm install -g playwright \
    && npx playwright install

# 5. Volver al usuario predeterminado de n8n
USER node 

# --- Configuración de n8n ---

# 6. Establecer el directorio de trabajo predeterminado de n8n
WORKDIR /usr/local/lib/node_modules/n8n

# 7. Exponer el puerto de n8n
EXPOSE 5678

# 8. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
