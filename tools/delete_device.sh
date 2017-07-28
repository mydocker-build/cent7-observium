#!/bin/bash
read -p "Enter hostname/IP: " host
docker exec -it observium /srv/observium/delete_device.php $host rrd
