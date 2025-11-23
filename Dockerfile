FROM odoo:17.0

# Install postgresql-client for health checks
USER root
RUN apt-get update && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*
USER odoo

# Create odoo configuration
RUN echo '[options]\n\
data_dir = /var/lib/odoo\n\
admin_passwd = farisjewelry123\n\
without_demo = all\n\
proxy_mode = True\n\
' > /etc/odoo/odoo.conf

CMD ["odoo", "--config=/etc/odoo/odoo.conf", "--http-interface=0.0.0.0", "--http-port=8069"]
