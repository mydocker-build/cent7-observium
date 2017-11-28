#!/bin/bash
read -p "Enter old hostname/IP: " oldhost
read -p "Enter new hostname/IP: " newhost
host=observium.sca-domain.com
docker exec -it $host /srv/observium/rename_device.php $oldhost $newhost
