
FROM debian:stable

WORKDIR /mariadb

# USER ROOT?

COPY . .


RUN apt-get update && apt-get upgrade -y && apt-get install mariadb-server mariadb-client -y

RUN mkdir -p /var/run/mysqld && chown -R mysql /var/run/mysqld && chmod -R 777 /var/run/mysqld

EXPOSE 3309

# CMD ["bash"]
# CMD [ "./script.sh" ]
