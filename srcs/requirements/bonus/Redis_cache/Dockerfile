
FROM debian:stable

#the rm -rf gonne reduce the image size adding to my docker knowledge
# RUN apt-get update && apt-get install -y redis-server && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y redis-server vim

# disable protected mode to allow connections from other machines
RUN sed -i "s/protected-mode yes/protected-mode no/g" /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server" , "/etc/redis/redis.conf", "--daemonize", "no"]