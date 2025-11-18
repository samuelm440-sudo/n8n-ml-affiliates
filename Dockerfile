# Dockerfile para n8n con Playwright (CORRECCIÓN FINAL)

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

# 4. Instalar la librería 'playwright' y sus navegadores
# Hacemos toda la instalación de NPM y binarios mientras somos root para evitar errores de permisos.
# Instalamos en la ubicación global /usr/local/lib/node_modules/
RUN npm install -g playwright \
    && npx playwright install --with-deps

# 5. Volver al usuario predeterminado de n8n
USER node 

# --- Configuración de n8n y Limpieza ---

# 6. Mover la librería 'playwright' a la ubicación de módulos accesibles por n8n (opcional, pero buena práctica)
# Ya está instalado globalmente, pero lo ponemos donde n8n pueda buscarlo fácilmente.
# Nota: Como se instaló con -g, el require('playwright') debería funcionar sin esto, pero lo mantenemos por seguridad.
# Sin embargo, si lo instalamos globalmente, n8n debe poder hacer require directamente. Simplificamos este paso.

WORKDIR /usr/local/lib/node_modules/n8n

# --- Tu Configuración Original ---

# 7. Exponer el puerto de n8n
EXPOSE 5678

# 8. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
