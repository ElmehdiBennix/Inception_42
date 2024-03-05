
FROM debian:stable

RUN apt-get update && apt-get install mariadb-server mariadb-client -y

WORKDIR /mariadb

EXPOSE 3309

COPY . .

# Create the log directory
RUN mkdir -p /var/run/mysqld && chown -R mysql /var/run/mysqld && chmod -R 777 /var/run/mysqld

CMD ["sh ./tools/script.sh"]