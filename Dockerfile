FROM odoo:17.0

# Security: Use non-root user and install security updates
USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Security: Create dedicated user
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo-user
USER odoo-user

# Copy secure startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
