#!/bin/bash
read -p "Enter old hostname/IP: " oldhost
read -p "Enter new hostname/IP: " newhost
docker exec -it observium /srv/observium/rename_device.php $oldhost $newhost
