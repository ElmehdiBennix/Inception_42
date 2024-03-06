
FROM debian:stable

RUN apt-get update && apt-get install mariadb-server expect -y

# RUN service mariadb stop

EXPOSE 3309

WORKDIR /mariadb

COPY . .

# Create the log directory

CMD ["sh","./tools/build_db.sh"]