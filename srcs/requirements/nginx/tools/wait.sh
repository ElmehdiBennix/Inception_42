#!/bin/bash

server = ""

server_status()
{
    mysql -h mariadb -P 3306 -u xmemyself -pME_mySELF@8520 -e "SELECT 1" > /dev/null 2>&1
    if [$? -eq 0]; then
        echo "mariadb is up and ready to be connected to\n"
        return 0;
    else
        echo "mariadb is down need more time to start ...\n"
        return 1;
}