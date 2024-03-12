FROM debian:stable

WORKDIR /var/www/html/wordpress

RUN apt-get update && apt-get install curl php-mysql php-fpm -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php

COPY . .

RUN chmod +x /tools/script.sh

CMD ["sh", "./tools/script.sh"]