
FROM debian:bullseye

RUN apt-get update \
    && apt-get install mariadb-server -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld \
    && chmod -R 755 /run/mysqld \
    && sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools /execute
RUN chmod +x /execute/build_db.sh

EXPOSE 3306/tcp

ENTRYPOINT [ "sh", "/execute/build_db.sh" ]
CMD [ "mysqld_safe" ]
