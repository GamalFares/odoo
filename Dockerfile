FROM odoo:17.0

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client \
        && rm -rf /var/lib/apt/lists/*

# Switch to odoo user and copy files as odoo user
USER odoo
COPY odoo.conf /etc/odoo/
COPY entrypoint.sh /

# REMOVE the chmod line - entrypoint.sh should already be executable
# If not, we'll make it executable in the entrypoint itself

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo", "--config=/etc/odoo/odoo.conf", "--http-interface=0.0.0.0", "--http-port=10000"]
