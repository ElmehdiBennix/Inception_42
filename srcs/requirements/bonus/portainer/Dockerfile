FROM debian:stable

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install wget -y

WORKDIR /portainer

RUN wget https://github.com/portainer/portainer/releases/download/2.21.1/portainer-2.21.1-linux-amd64.tar.gz

CMD [ "sleep", "200000"]
