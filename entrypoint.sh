#!/bin/bash
set -e

# Wait for database to be ready
while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER; do
    echo "Waiting for database..."
    sleep 2
done

# Start Odoo
exec "$@"
