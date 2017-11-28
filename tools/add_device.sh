#!/bin/bash
read -p "Enter hostname/IP: " host
read -p "Enter community: " community
read -p "Enter SNMPv (v1|v2c): " snmpv
host=observium.sca-domain.com
docker exec -it $host /srv/observium/add_device.php $host $community $snmpv
docker exec -it $host /srv/observium/discovery.php -h new
docker exec -it $host /srv/observium/poller.php -h new
