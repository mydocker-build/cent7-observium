#!/bin/bash
docker exec -it observium /srv/observium/discovery.php -h all
docker exec -it observium /srv/observium/poller-wrapper.py
