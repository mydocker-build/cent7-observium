#!/bin/bash
read -p "Enter hostname/IP: " host
host=observium.sca-domain.com
docker exec -it $host /srv/observium/delete_device.php $host rrd
