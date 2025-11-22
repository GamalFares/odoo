FROM odoo:17.0

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client \
        && rm -rf /var/lib/apt/lists/*

USER odoo
COPY odoo.conf /etc/odoo/
COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
# CRITICAL: Add this CMD line
CMD ["odoo", "--config=/etc/odoo/odoo.conf", "--http-interface=0.0.0.0", "--http-port=10000"]
