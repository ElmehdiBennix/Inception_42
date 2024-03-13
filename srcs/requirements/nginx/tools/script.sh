#!/bin/bash

# nginx -v

# openssl x509 -in /etc/ssl/certs/nginx-selfsigned.crt -text -noout

rm -rf /etc/nginx/sites-enabled/*

mv /nginx/conf/nginx.conf /etc/nginx/sites-enabled

nginx -g 'daemon off;'

