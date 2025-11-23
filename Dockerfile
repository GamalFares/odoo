FROM odoo:17.0

# Install postgresql-client for health checks
USER root
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*
USER odoo

# Create a robust startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
