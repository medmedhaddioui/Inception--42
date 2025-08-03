FROM debian:stable

# Install PHP and required extensions
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-curl \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Add setup script
COPY tools/script.sh /script.sh
RUN chmod +x /script.sh

# Ensure runtime directories exist
RUN mkdir -p /run/php

CMD ["bash", "/script.sh"]
