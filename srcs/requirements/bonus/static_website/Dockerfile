FROM debian:stable

WORKDIR /var/www/html

RUN apt-get update && apt-get install lighttpd -y

COPY ./conf .

RUN chmod -R 755 ../html

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]