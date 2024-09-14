FROM debian:stable

WORKDIR /var/www/html/adminer

RUN apt-get update && apt install wget php-mysql php8.2-fpm adminer netcat-traditional -y

RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer/adminer.php

RUN chmod 755 /var/www/html/adminer/adminer.php

RUN sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 8080|g" /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 8080

COPY ./tools/sync.sh /execute/sync.sh

RUN chmod -R +x /execute

ENTRYPOINT [ "sh", "/execute/sync.sh" ]

CMD ["/usr/sbin/php-fpm8.2", "-F"]
