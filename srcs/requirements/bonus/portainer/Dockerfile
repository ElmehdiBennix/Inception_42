FROM debian:stable

RUN apt-get update \
    && apt-get install wget -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /portainer

RUN wget https://github.com/portainer/portainer/releases/download/2.21.1/portainer-2.21.1-linux-amd64.tar.gz -O portainer.tar.gz

# EXPOSE

# ENTRYPOINT [ "sleep", "200000"]
# CMD [ "sleep", "200000"]
