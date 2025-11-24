FROM odoo:17.0

# Security: Install security updates and postgresql-client
USER root
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Copy secure startup script (as root, then set permissions)
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Switch to odoo user for security
USER odoo

CMD ["/start.sh"]
