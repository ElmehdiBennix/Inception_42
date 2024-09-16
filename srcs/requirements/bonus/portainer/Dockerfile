FROM debian:bullseye

RUN apt-get update \
    && apt-get install wget -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /portainer

RUN wget https://github.com/portainer/portainer/releases/download/2.21.1/portainer-2.21.1-linux-amd64.tar.gz -O portainer.tar.gz \
    && tar -xvf portainer.tar.gz \
    && rm -rf portainer.tar.gz

#maybe create a admine user before
EXPOSE 9000/tcp

ENTRYPOINT [ "./portainer/portainer" ]
