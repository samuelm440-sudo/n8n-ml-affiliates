# Dockerfile para n8n con Playwright (VERSIÓN 5: Instalación Localizada)

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

# 4. Establecer el directorio de trabajo donde reside n8n y sus módulos
# Playwright intentará instalar binarios aquí también, y es donde debe estar el paquete.
WORKDIR /usr/local/lib/node_modules/n8n

# 5. Instalar la librería 'playwright' y sus navegadores
# La instalación local de NPM no necesita -g.
RUN npm install playwright \
    && npx playwright install

# 6. Volver al usuario predeterminado de n8n
USER node 

# --- Configuración de n8n ---

# 7. Exponer el puerto de n8n
EXPOSE 5678

# 8. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
