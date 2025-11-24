#!/bin/bash
set -e

echo "🔒 SECURE STARTUP: Faris Jewelry Odoo System"
echo "📊 Database: ${DB_HOST}:${DB_PORT}"
echo "🌐 Port: ${PORT}"
echo "⏰ $(date)"

# Validate environment variables
required_vars=("DB_HOST" "DB_PASSWORD" "ADMIN_PASSWORD" "DB_USER" "DB_NAME")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "❌ CRITICAL: Missing environment variable: $var"
        exit 1
    fi
done

echo "✅ All environment variables present"

# Substitute environment variables in config template
echo "⚙️ Generating secure configuration..."
envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf

# Wait for database with timeout
echo "⏳ Establishing secure database connection..."
timeout 60s bash -c "
    while ! pg_isready -h \$DB_HOST -p \$DB_PORT -U \$DB_USER; do
        echo 'Database connection in progress...'
        sleep 2
    done
"

if [ $? -ne 0 ]; then
    echo "❌ DATABASE CONNECTION TIMEOUT"
    exit 1
fi

echo "✅ Secure database connection established"

# Start Odoo with config file
echo "🚀 Starting secured Odoo instance..."
exec odoo --config=/etc/odoo/odoo.conf
