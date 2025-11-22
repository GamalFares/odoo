#!/bin/bash
set -e

echo "Waiting for database at ${DB_HOST}:${DB_PORT}..."
while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER; do
    echo "Database not ready yet. Waiting..."
    sleep 2
done

echo "Database is ready! Starting Odoo..."
exec "$@"
