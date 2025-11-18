# Dockerfile para n8n con Playwright (VERSIÓN 9: Instalación Forzada y Limpia)

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

# 4. Establecer el directorio de trabajo principal de n8n
# Este directorio contiene las librerías principales de n8n y su package.json
WORKDIR /usr/local/lib/node_modules/n8n

# 5. INSTALAR PLAYWRIGHT LOCALMENTE SIN CONFLICTOS:
# --prefix . instala el paquete en ./node_modules, asegurando que esté en una ruta que n8n respeta.
# El conflicto anterior de 'workspace:*' se maneja mejor en versiones recientes de NPM, o lo evitamos con este comando.
RUN npm install --prefix . playwright 

# 6. Instalar los binarios de Playwright (usa la instalación local anterior)
RUN npx playwright install

# 7. Volver al usuario predeterminado de n8n y limpiar ENV
USER node 
# (Se eliminan NODE_PATH y npm-install-local)

# --- Configuración de n8n ---

# 8. Exponer el puerto de n8n
EXPOSE 5678

# 9. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https

# 10. ¡ÚLTIMO RECURSO DE SEGURIDAD!
# Si la Solución 9 aún falla, usa esta variable de entorno:
# ENV N8N_VM_CODE_LOW_SECURITY_MODE=true
