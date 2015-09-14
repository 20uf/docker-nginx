#!/bin/bash

HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
echo -e "\n${HOST_IP} symfony" >> /etc/hosts

service nginx start
service php5-fpm start

while true; do sleep 1d; done
