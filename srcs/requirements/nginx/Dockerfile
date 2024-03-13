
FROM debian:stable

RUN apt-get update && apt-get install nginx openssl -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MA/ST=beni_mellal/L=khouribga/O=42/OU=42/CN=ebennix.42.fr"

RUN rm -rf /etc/nginx/sites-enabled/*

COPY ./conf/nginx.conf /etc/nginx/sites-enabled

RUN chmod +r /etc/nginx/sites-enabled/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
