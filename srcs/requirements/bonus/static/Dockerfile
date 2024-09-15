
FROM debian:stable

RUN apt-get update \
    && apt-get install lighttpd -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf /var/www/html
RUN chmod -R 755 /var/www/html

EXPOSE 80

CMD [ "lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]
