
FROM debian:stable

RUN apt-get update \
    && apt-get install wget php-mysql php8.2-fpm netcat-traditional -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools /execute
RUN chmod -R +x /execute

EXPOSE 9000/tcp

ENTRYPOINT ["sh", "/execute/init_wp.sh" ]
CMD ["/usr/sbin/php-fpm8.2", "-F"]
