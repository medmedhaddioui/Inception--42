FROM debian:bookworm

# Install PHP and required extensions
RUN apt-get update -y && \
    apt-get install -y \
    curl \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-cli \
    php8.2-curl \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip && \
    rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Add setup script
COPY tools/script.sh /script.sh
RUN chmod +x /script.sh

# Ensure runtime directories exist
RUN mkdir -p /run/php

CMD ["bash", "/script.sh"]
# 