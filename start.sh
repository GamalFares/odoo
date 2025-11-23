#!/bin/bash
export LC_ALL=C

# Wait for database
echo "Waiting for database..."
sleep 10

# Substitute environment variables
envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf

# Start Odoo with asset regeneration
exec odoo --config=/etc/odoo/odoo.conf --http-interface=0.0.0.0 --http-port=$PORT --dev=all
