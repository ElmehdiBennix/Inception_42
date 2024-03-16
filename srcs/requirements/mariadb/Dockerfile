
FROM debian:stable

RUN apt-get update && apt-get install mariadb-server -y

RUN mkdir -p /var/run/mysqld && chown -R mysql /var/run/mysqld && chmod 777 /var/run/mysqld

# Bind address to 0.0.0.0 to allow connections from any IP address
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/build_db.sh /init/build_db.sh

EXPOSE 3306

RUN chmod +x /init/build_db.sh

CMD ["sh", "/init/build_db.sh"]

#TODO entry as exec for setup in script and arg as mysqld def