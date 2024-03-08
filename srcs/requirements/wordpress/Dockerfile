
FROM debian:stable

RUN apt-get update && apt-get install wp-cli -y
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar


WORKDIR /wordpress

EXPOSE 9000

COPY . .

CMD [ "executable" ]