#!/bin/bash
read -p "Enter username: " username
read -s -p "Enter password: " password
read -p "Enter lv 0)Disabled | 1)Normal | 5)Global Read | 7)Global Secure Read | 8)Global Secure Read / Limited Write | 10)Administrator: " lv
host=observium.sca-domain.com
docker exec -it $host /srv/observium/adduser.php $username $password $lv
