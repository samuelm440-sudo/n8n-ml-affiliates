# n8n + Mercado Libre Afiliados

Automación para generar links de afiliados de Mercado Libre cada 6 horas.

## Deploy en Render

1. Conecta este repositorio a Render
2. Usa el `render.yaml` para configuración automática
3. Las variables de entorno ya están configuradas

## Variables de Entorno Requeridas

- `N8N_BASIC_AUTH_USER`: Usuario para autenticación
- `N8N_BASIC_AUTH_PASSWORD`: Contraseña para autenticación
- `N8N_WEBHOOK_URL`: URL pública de tu instancia

## Configuración Mercado Libre

1. Crea app en: https://developers.mercadolibre.com.mx/
2. Redirect URI: `https://[tu-domain].onrender.com/rest/oauth2-credential/callback`
3. Obtén Client ID y Client Secret
