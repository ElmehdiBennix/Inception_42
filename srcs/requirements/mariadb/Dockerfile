
FROM debian:stable

RUN apt-get update && apt-get install mariadb-server expect -y

EXPOSE 3309

WORKDIR /task_file

COPY . .

# RUN chmod +x ./tools/build_db.sh

# Create the log directory
# ENTRYPOINT [ "executable" ]

CMD ["sh","./tools/build_db.sh"]