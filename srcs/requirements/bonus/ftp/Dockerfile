
FROM debian:stable

RUN apt-get update \
    && apt-get install vsftpd netcat-traditional -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools /execute
RUN chmod -R +x /execute

EXPOSE 21/tcp 30000-30009/tcp

ENTRYPOINT [ "sh", "/execute/init_ftp.sh" ]
CMD [ "vsftpd", "/etc/vsftpd.conf" ]
