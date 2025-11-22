#!/bin/bash
export LC_ALL=C
envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf
exec odoo --config=/etc/odoo/odoo.conf --http-interface=0.0.0.0 --http-port=10000
