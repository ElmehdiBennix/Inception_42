FROM debian:stable

RUN groupadd --system prometheus
RUN useradd -s /sbin/nologin --system -g prometheus prometheus

RUN apt-get update && apt-get install vim -y
