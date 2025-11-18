# Dockerfile para n8n con Playwright (VERSIÓN 8: Instalación Local Forzada)

FROM n8nio/n8n

USER root

# 1. Instalar las dependencias de Linux (igual que antes)
RUN apk update \
    && apk add --no-cache \
    udev \
    ttf-freefont \
    libstdc++ \
    nss \
    mesa-gl \
    chromium \
    && rm -rf /var/cache/apk/*

# 2. Instalar una utilidad para forzar la instalación local
# Esto nos permite instalar Playwright sin conflictos de 'workspace:*'
RUN npm install -g npm-install-local

# 3. Movernos al directorio de trabajo principal de n8n
WORKDIR /usr/local/lib/node_modules/n8n

# 4. Crear la carpeta node_modules local si no existe (normalmente ya existe)
RUN mkdir -p node_modules

# 5. Instalar Playwright DENTRO de la carpeta node_modules de n8n
# npm-install-local (n-i-l) instala la dependencia directamente, saltándose el chequeo de package.json
RUN n-i-l playwright

# 6. Instalar los binarios de Playwright
# Se ejecuta en el mismo WORKDIR, por lo que los binarios se descargan aquí.
RUN npx playwright install

# 7. Limpieza y usuario
USER node 
# ... el resto de tus configuraciones (EXPOSE, ENVs) ...
