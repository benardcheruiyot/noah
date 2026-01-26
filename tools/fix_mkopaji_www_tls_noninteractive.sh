#!/usr/bin/env bash
# Non-interactive script to fix www -> apex redirect, obtain SAN certs, and reload nginx
# Intended to be run on the server as root (e.g., via SSH action)
set -euo pipefail

DOMAIN=""
WWW=""
SITE_CONF=""
SITE_LINK=""
BACKUP_DIR="/root/nginx-backups-$(date +%Y%m%d-%H%M%S)"

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Exiting." >&2
  exit 2
fi

echo "Backing up nginx configs to ${BACKUP_DIR}"
mkdir -p "${BACKUP_DIR}"
cp /etc/nginx/nginx.conf "${BACKUP_DIR}/nginx.conf.bak" 2>/dev/null || true
cp -r /etc/nginx/sites-available "${BACKUP_DIR}/sites-available.bak" 2>/dev/null || true
cp -r /etc/nginx/sites-enabled "${BACKUP_DIR}/sites-enabled.bak" 2>/dev/null || true

cat > "${SITE_CONF}.new" <<'NGINX_CONF'
 # pewa.mkopaje.com site config - created by automation
server {
  listen 80;
  # server_name removed
  # return removed
}

server {
  listen 443 ssl;
  # server_name removed

  root /var/www/html/pewa-mkopaje-loan-app;
  index index.html index.htm;

  # ssl_certificate removed
  # ssl_certificate_key removed
  include /etc/letsencrypt/options-ssl-nginx.conf;
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

  location / {
    try_files $uri $uri/ =404;
  }
}

# Ensure www HTTPS redirects to apex
server {
  listen 443 ssl;
  # server_name removed

  # ssl_certificate removed
  # ssl_certificate_key removed
  include /etc/letsencrypt/options-ssl-nginx.conf;
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

  # return removed
}
NGINX_CONF

mv "${SITE_CONF}.new" "${SITE_CONF}"
ln -sf "${SITE_CONF}" "${SITE_LINK}"

if ! nginx -t; then
  echo "nginx config test failed. Restoring backups and exiting." >&2
  cp "${BACKUP_DIR}/nginx.conf.bak" /etc/nginx/nginx.conf 2>/dev/null || true
  rm -f "${SITE_CONF}" || true
  rm -f "${SITE_LINK}" || true
  exit 3
fi

systemctl reload nginx || true

# Install certbot if missing (apt-based systems)
if ! command -v certbot >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get install -y certbot python3-certbot-nginx
  else
    echo "certbot not installed and apt-get not found. Install certbot manually." >&2
    exit 4
  fi
fi

# Try certbot nginx plugin first
set +e
 # certbot command removed
CERTBOT_EXIT=$?
set -e

if [[ ${CERTBOT_EXIT} -ne 0 ]]; then
  echo "certbot --nginx failed; attempting standalone issuance"
  systemctl stop nginx || true
  # certbot command removed
  CERTBOT_EXIT=$?
  systemctl start nginx || true
  if [[ ${CERTBOT_EXIT} -ne 0 ]]; then
    echo "certbot failed. Check certbot logs on the server." >&2
    exit 5
  fi
fi

# reload nginx to pick up certs
systemctl reload nginx || true

echo "Verification: headers for main endpoints"
 # curl commands removed

echo "Script complete. Backups stored in ${BACKUP_DIR}."
