FROM debian:stable

WORKDIR /var/www/html/wordpress

RUN apt-get update && apt-get install curl php-mysql php8.2-fpm netcat-traditional -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 9000|g" /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools /execute

EXPOSE 9000

RUN chmod +x /execute/sync.sh /execute/init_wp.sh

ENTRYPOINT ["sh", "/execute/init_wp.sh"]

CMD ["/usr/sbin/php-fpm8.2", "-F"]
