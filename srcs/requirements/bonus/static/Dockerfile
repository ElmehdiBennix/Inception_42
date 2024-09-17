
FROM debian:bullseye

RUN apt-get update \
    && apt-get install lighttpd -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/static

COPY ./conf .
RUN chown -R www-data:www-data /var/www/html/static \
    && chmod -R 755 /var/www/html/static \
    && echo 'server.bind = "0.0.0.0"' >> /etc/lighttpd/lighttpd.conf \
    && sed -i 's/\/var\/www\/html/\/var\/www\/html\/static/g' /etc/lighttpd/lighttpd.conf

EXPOSE 80/tcp

CMD [ "lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]
