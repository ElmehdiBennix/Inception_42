
FROM debian:stable

RUN apt-get update && apt-get install nginx openssl -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MA/ST=beni_mellal/L=khouribga/O=1337/OU=1337/CN=ebennix.42.fr"

RUN rm -rf /etc/nginx/sites-enabled/* /etc/nginx/sites-available/* /var/www/html/index.nginx-debian.html

COPY ./conf/nginx.conf /etc/nginx/sites-available/nginx.conf

RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

RUN chmod +r /etc/nginx/sites-available/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
