FROM odoo:17.0

USER root
# Install envsubst and postgresql-client
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client \
        gettext-base \
        && rm -rf /var/lib/apt/lists/*

# Copy template and startup script
COPY odoo.conf.template /etc/odoo/
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
