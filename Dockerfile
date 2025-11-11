FROM n8nio/n8n:latest-puppeteer

# Configuración de Puppeteer para Render.com
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_LAUNCH_OPTIONS='{"args":["--no-sandbox","--disable-setuid-sandbox","--disable-dev-shm-usage","--disable-gpu","--single-process","--disable-features=site-per-process"]}'

EXPOSE 5678
CMD ["node", "packages/cli/dist/index.js"]
