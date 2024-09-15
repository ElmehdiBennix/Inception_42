
FROM debian:stable

RUN apt-get update \
    && apt install wget php-mysql php8.2-fpm adminer netcat-traditional -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/adminer
RUN wget "http://www.adminer.org/latest.php" -O adminer.php \
    && chmod -R 755 /var/www/html/adminer \
    && sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 8080|g" /etc/php/8.2/fpm/pool.d/www.conf

COPY ./tools /execute
RUN chmod -R +x /execute

EXPOSE 8080/tcp

ENTRYPOINT [ "sh", "/execute/sync.sh" ]
CMD ["/usr/sbin/php-fpm8.2", "-F"]
