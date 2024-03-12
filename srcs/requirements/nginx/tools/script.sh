#!/bin/bash

nginx -v

openssl x509 -in /etc/ssl/certs/nginx-selfsigned.crt -text -noout



