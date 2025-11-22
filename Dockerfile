FROM odoo:17.0
COPY odoo.conf /etc/odoo/
CMD ["odoo", "--config=/etc/odoo/odoo.conf", "--http-interface=0.0.0.0", "--http-port=10000"]
