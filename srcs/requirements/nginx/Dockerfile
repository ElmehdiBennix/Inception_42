
FROM debian:stable

RUN apt-get update && apt-get install nginx openssl netcat-traditional -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MA/ST=beni_mellal/L=khouribga/O=1337/OU=1337/CN=ebennix.42.fr"
    # &&

RUN chown -R www-data /var/www/html && chmod 755 /var/www/html

RUN rm -rf /etc/nginx/sites-enabled/* /etc/nginx/sites-available/* /var/www/html/index.nginx-debian.html

COPY ./conf/nginx.conf /etc/nginx/sites-available/nginx.conf

RUN chmod +r /etc/nginx/sites-available/nginx.conf

RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/


COPY ./tools/sync.sh /execute/sync.sh
RUN chmod +x /execute/sync.sh

EXPOSE 443

ENTRYPOINT ["sh", "/execute/sync.sh"]
CMD ["nginx", "-g", "daemon off;"]
