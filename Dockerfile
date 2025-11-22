FROM odoo:17.0

# Install additional dependencies for jewelry business
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-pip \
        python3-dev \
        build-essential \
        && rm -rf /var/lib/apt/lists/*

# Switch back to odoo user
USER odoo

# Copy Odoo configuration
COPY odoo.conf /etc/odoo/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
