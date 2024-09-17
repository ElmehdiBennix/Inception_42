
FROM debian:bullseye

RUN apt-get update \
    && apt-get install wget php-mysql php7.4-fpm adminer netcat-traditional -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/adminer
RUN wget "http://www.adminer.org/latest.php" -O adminer.php \
    && chmod -R 755 /var/www/html/adminer \
    && sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 8080|g" /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools /execute
RUN chmod -R +x /execute

EXPOSE 8080/tcp

ENTRYPOINT [ "sh", "/execute/sync.sh" ]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
