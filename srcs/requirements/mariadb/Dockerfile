
FROM debian:stable

RUN apt-get update && apt-get install mariadb-server -y

# RUN service mariadb stop
# RUN mkdir -p /run/mysqld && chown -R mysql /run/mysqld && chmod -R 777 /run/mysqld

EXPOSE 3309

WORKDIR /mariadb

COPY . .

# Create the log directory

CMD ["sh", "./tools/script.sh"]