# 1. Usamos la versión DEBIAN (Crucial para que Playwright funcione fácil)
FROM n8nio/n8n:latest-debian

USER root

# 2. Instalar dependencias del sistema necesarias para correr navegadores
# Estas son librerías de linux que Chromium necesita para arrancar
RUN apt-get update && apt-get install -y \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 3. Instalar Playwright y los navegadores
# Lo instalamos en la carpeta global de n8n para que el nodo lo encuentre
RUN npm install -g playwright

# 4. Instalar los binarios de Chromium (Navegador)
RUN npx playwright install chromium --with-deps

# 5. Configurar variables de entorno para que n8n sepa dónde buscar
ENV NODE_PATH=/usr/local/lib/node_modules

# 6. Volver al usuario node por seguridad
USER node
