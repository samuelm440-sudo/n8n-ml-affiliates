FROM n8nio/n8n

# Exponer el puerto de n8n
EXPOSE 5678

# Variables de entorno básicas
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_PROTOCOL=https
