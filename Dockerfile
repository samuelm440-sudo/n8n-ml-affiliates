# Dockerfile para n8n con Playwright (CORRECCIÓN FINAL)

# 1. Usar la imagen base oficial de n8n
FROM n8nio/n8n

# --- Instalación de Dependencias de Playwright (Requiere Root) ---

# 2. Cambiar temporalmente a usuario root para obtener permisos de instalación
USER root

# 3. Instalar las dependencias del sistema requeridas por Playwright (usando apk)
RUN apk update \
    && apk add --no-cache \
    udev \
    ttf-freefont \
    libstdc++ \
    nss \
    mesa-gl \
    chromium \
    # Limpiar caché
    && rm -rf /var/cache/apk/*

# 4. Cambiar de nuevo al usuario predeterminado de n8n
# Esto asegura que los siguientes comandos y el servicio n8n se ejecuten con permisos limitados (seguridad).
USER node 

# --- Instalación del Módulo Playwright (Permisos de Usuario Estándar) ---

# 5. Establecer un directorio de trabajo temporal para la instalación de Playwright
WORKDIR /tmp/playwright_install

# 6. Inicializar un nuevo proyecto simple y instalar la librería 'playwright'
RUN npm init -y \
    && npm install playwright \
    && npx playwright install --with-deps

# 7. Mover los módulos instalados a la ubicación global de Node.js
RUN mv node_modules/playwright /usr/local/lib/node_modules/playwright

# 8. Limpiar el directorio temporal y volver al directorio de trabajo original de n8n
RUN rm -rf /tmp/playwright_install
WORKDIR /usr/local/lib/node_modules/n8n

# --- Tu Configuración Original ---

# 9. Exponer el puerto de n8n
EXPOSE 5678

# 10. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
