FROM odoo:17.0

# Install postgresql-client for health checks
USER root
RUN apt-get update && \
    apt-get install -y postgresql-client gettext-base && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Create odoo configuration directory
RUN mkdir -p /etc/odoo

# Copy configuration template and startup script
COPY odoo.conf.template /etc/odoo/
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Switch to odoo user for security
USER odoo

CMD ["/start.sh"]
