#!/bin/bash

container="mariadb"
port="3306"

service_status()
{
    nc -zv $container $port > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0;
    else
        echo "Waiting for $container on $port..."
        return 1;
    fi
}

while ! service_status; do
    sleep 0.5
done

echo "<=== Starting wordpress Execution ===>"
