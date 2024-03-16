#!/bin/bash

server = "wordpress"
port = "9000"

server_status()
{
    nc -zv $server $port > /dev/null 2>&1
    if [$? -eq 0]; then
        echo "$server is up\n"
        return 0;
    else
        echo "$server is down\n"
        return 1;
}

while !server_status; do
    sleep 2
done

echo "$server is up and ready to be connected to :"