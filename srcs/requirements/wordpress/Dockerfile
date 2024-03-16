FROM debian:stable

WORKDIR /var/www/html/wordpress

RUN apt-get update && apt-get install curl php-mysql php8.2-fpm mariadb-client -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 9000|g" /etc/php/8.2/fpm/pool.d/www.conf

# RUN mkdir /execute

COPY ./tools/script.sh /execute/script.sh

EXPOSE 9000

RUN chmod +x /execute/script.sh

CMD ["sh", "/execute/script.sh"]

#entry point too and exec as php fast proccess manager