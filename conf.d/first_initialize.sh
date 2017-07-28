#!/bin/bash
# First initialization
dir_obs=/srv/observium
if [ -f $dir_obs/config.php ]; then
        echo "Start existing Observium Database...!"
else
        echo "Observium initialize configuration and database...!"
        cd $dir_obs/ && cp config.php.default config.php && \
        sed -i '17i$config['fping'] = "/usr/sbin/fping";' config.php && \
        ./discovery.php -u
fi

# Check configuration
chk_host=`grep localhost $dir_obs/config.php|awk '{print $3}'`
if [ "$chk_host" == "'localhost';" ]; then
        echo "Configuration has been changed...!"
	cd $dir_obs/
        sed -i "s/'localhost'/'$DB_OBSERVIUM_HOST'/" config.php && \
        sed -i "s/'USERNAME'/'$DB_OBSERVIUM_USER'/" config.php && \
        sed -i "s/'PASSWORD'/'$DB_OBSERVIUM_PASSWORD'/" config.php && \
        sed -i "s/'observium'/'$DB_OBSERVIUM_NAME'/" config.php && \
        exit
fi

