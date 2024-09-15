
FROM debian:stable

RUN apt-get update \
    && apt-get install redis-server -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/bind 127.0.0.1 -::1/bind 0.0.0.0 ::1/g" /etc/redis/redis.conf \
    && sed -i "s/protected-mode yes/protected-mode no/g" /etc/redis/redis.conf

EXPOSE 6379/tcp

ENTRYPOINT [ "redis-server" ]
CMD [ "/etc/redis/redis.conf", "--daemonize", "no" ]
