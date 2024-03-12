#!/bin/bash

nginx -v

openssl x509 -in /etc/ssl/certs/nginx-selfsigned.crt -text -noout

rm -rf /etc/nginx/sites-available/* /etc/nginx/sites-enabled/*

mv ./conf/nginx.conf /etc/nginx


