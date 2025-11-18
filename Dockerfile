# Dockerfile CORREGIDO

# 1. Usar la imagen base oficial de n8n
FROM n8nio/n8n

# --- Instalación de Playwright y sus dependencias ---

# 2. Instalar las dependencias del sistema requeridas por Playwright (usando apk para Alpine)
# Primero, actualizar y luego instalar los paquetes
RUN apk update \
    && apk add --no-cache \
    # Dependencias de Playwright (estas son comunes en Alpine)
    udev \
    ttf-freefont \
    libstdc++ \
    chromium \
    # Dependencias adicionales comunes para navegadores
    nss \
    mesa-gl \
    # Limpiar caché después de instalar
    && rm -rf /var/cache/apk/*

# 3. Cambiar al directorio de módulos de n8n para instalar Playwright
WORKDIR /usr/local/lib/node_modules/n8n/node_modules

# 4. Instalar la librería 'playwright' y sus navegadores
# Nota: La imagen base de n8n ya debería tener muchas de estas librerías. 
# Si el paso 2 falla, podríamos simplificarlo solo instalando Playwright y dejando que instale sus propios deps.
RUN npm install playwright \
    && npx playwright install --with-deps

# 5. Volver al directorio de trabajo original (donde se ejecuta n8n)
WORKDIR /usr/local/lib/node_modules/n8n

# --- Tu Configuración Original (Mantenida) ---

# 6. Exponer el puerto de n8n
EXPOSE 5678

# 7. Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
