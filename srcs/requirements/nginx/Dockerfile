
FROM debian:stable

RUN apt-get update && apt-get install nginx openssl -y

EXPOSE 443

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt -subj ${CERTS_}

WORKDIR /nginx

COPY . .

CMD [ "sh", "./tools/script.sh" ]