# Dockerfile SIMPLIFICADO (Si la versión anterior falla)

FROM n8nio/n8n

# Instalar Playwright directamente en el directorio de módulos
WORKDIR /usr/local/lib/node_modules/n8n/node_modules

# Instalar la librería 'playwright' y sus navegadores (Playwright intentará instalar las dependencias)
RUN npm install playwright \
    && npx playwright install --with-deps

WORKDIR /usr/local/lib/node_modules/n8n

EXPOSE 5678

ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
