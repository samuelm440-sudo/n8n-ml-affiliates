# 1. Usar la imagen base oficial de n8n
FROM n8nio/n8n

# --- Instalación de Playwright y sus dependencias ---

# 2. Instalar las dependencias del sistema requeridas por Playwright
# Estas librerías son esenciales para que los navegadores headless funcionen en Linux (el contenedor).
# Se usan los flags --no-install-recommends para mantener el tamaño del contenedor pequeño.
RUN apt-get update \
    && apt-get install -y \
    libnss3 \
    libasound2 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libxshmfence6 \
    libxtst6 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 3. Cambiar al directorio de módulos de n8n para instalar Playwright como dependencia accesible
# Esto asegura que el nodo 'Code' pueda encontrar la librería.
WORKDIR /usr/local/lib/node_modules/n8n/node_modules

# 4. Instalar la librería 'playwright' y sus navegadores
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
