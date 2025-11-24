#!/bin/bash
set -e

# Security: Log security events
echo "🔒 SECURE STARTUP: Faris Jewelry Odoo System"
echo "📊 Database: ${DB_HOST}:${DB_PORT}"
echo "🌐 Port: ${PORT}"
echo "⏰ $(date)"

# Security: Validate environment variables
if [ -z "$DB_HOST" ] || [ -z "$DB_PASSWORD" ] || [ -z "$ADMIN_PASSWORD" ]; then
    echo "❌ CRITICAL: Missing required environment variables"
    exit 1
fi

# Security: Wait for database with timeout
echo "⏳ Establishing secure database connection..."
timeout 60s bash -c "
    while ! pg_isready -h \$DB_HOST -p \$DB_PORT -U \$DB_USER; do
        echo 'Database connection in progress...'
        sleep 2
    done
"

if [ $? -ne 0 ]; then
    echo "❌ DATABASE CONNECTION TIMEOUT: Check credentials and network"
    exit 1
fi

echo "✅ Secure database connection established"

# Security: Start Odoo with production hardening
echo "🚀 Starting secured Odoo instance..."
exec odoo \
  --db_host="$DB_HOST" \
  --db_port="$DB_PORT" \
  --db_user="$DB_USER" \
  --db_password="$DB_PASSWORD" \
  --database="$DB_NAME" \
  --admin-passwd="$ADMIN_PASSWORD" \
  --without-demo=all \
  --http-interface=0.0.0.0 \
  --http-port="$PORT" \
  --proxy-mode \
  --workers=2 \
  --limit-memory-soft=402653184 \
  --limit-memory-hard=536870912 \
  --limit-time-cpu=60 \
  --limit-time-real=120 \
  --max-cron-threads=1 \
  --data-dir=/tmp/odoo-data \
  --log-level=warn#!/bin/bash
export LC_ALL=C

# Wait for database
echo "Waiting for database..."
sleep 10

# Substitute environment variables
envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf

# Start Odoo with asset regeneration
exec odoo --config=/etc/odoo/odoo.conf --http-interface=0.0.0.0 --http-port=$PORT --dev=all
