
FROM debian:stable

RUN apt-get update && apt-get install nginx -y

# EXPOSE 443

WORKDIR /nginx

COPY . .

CMD [ "bash" ]