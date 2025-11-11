FROM n8nio/n8n:puppeteer

# Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=4455668822
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://tu-app.render.com

# Exponer puerto
EXPOSE 5678

# Comando de inicio
CMD ["n8n", "start"]
