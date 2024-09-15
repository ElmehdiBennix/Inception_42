
FROM debian:stable

RUN apt-get update \
    && apt-get install nginx openssl netcat-traditional -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/nginx/sites-enabled/* /etc/nginx/sites-available/* /var/www/html/index.nginx-debian.html \
    && chown -R www-data /var/www/html \
    && chmod 755 /var/www/html

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MA/ST=beni_mellal/L=khouribga/O=1337/OU=1337/CN=ebennix.42.fr"

COPY ./tools/sync.sh ./conf/nginx.conf /execute/
RUN chmod -R +rx /execute \
    && mv /execute/nginx.conf /etc/nginx/sites-available \
    && ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled

EXPOSE 443

ENTRYPOINT [ "sh", "/execute/sync.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]
