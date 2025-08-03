FROM debian:stable

RUN apt update && apt upgrade -y && \
        apt install -y nginx vim openssl

RUN mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/html

RUN openssl req -x509 -nodes -days 365\ 
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=MA/ST=NA/L=Benguerir/O=42/OU=42/CN=mel-hadd.42.fr/UID=mel-hadd"

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
