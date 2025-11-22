#!/bin/bash

# Set locale to avoid warnings
export LC_ALL=C

# Substitute environment variables in odoo.conf
envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf

# Wait for database
echo "Waiting for database at ${DB_HOST}:5432 as user ${DB_USER}..."
while ! pg_isready -h $DB_HOST -p 5432 -U $DB_USER; do
    echo "Database not ready yet. Waiting..."
    sleep 2
done

echo "Database is ready! Starting Odoo..."
exec odoo --config=/etc/odoo/odoo.conf --http-interface=0.0.0.0 --http-port=10000
