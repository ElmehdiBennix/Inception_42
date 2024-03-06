#!/bin/bash

service mariadb start

# tape fix ping the database after to check if its up or not
sleep 4

# if [ -d "/var/lib/mysql/$MARIADB_DATABASE" ]
# then 
# 	echo "database already exists !!! we gone use it ."
# else

./tools/install.exp

