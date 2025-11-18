# Dockerfile para n8n con Playwright (VERSIÓN 10: Global + Baja Seguridad)

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

# 7. **LA SOLUCIÓN:** Desactivar la sandbox de VM2 para permitir require() globales
# ¡ADVERTENCIA! Esto reduce la seguridad de los nodos Code, dándoles acceso completo al sistema.
ENV N8N_VM_CODE_LOW_SECURITY_MODE=true

# 8. Volver al usuario predeterminado de n8n
USER node 

# --- Configuración de n8n ---

# 9. Exponer el puerto de n8n
EXPOSE 5678

# 10. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
