#!/bin/bash
host=observium.sca-domain.com
docker exec -it $host /srv/observium/discovery.php -h all
docker exec -it $host /srv/observium/poller-wrapper.py
