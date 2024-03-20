#!/bin/bash

server="mariadb"
port="3306"

server_status()
{
    nc -zv $server $port > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$server on $port is up\n"
        return 0;
    else
        echo "$server on $port is down\n"
        return 1;
    fi
}

while ! server_status; do
    sleep 2
done

echo "$server on $port is up and ready to be connected to :"

exec "$@"