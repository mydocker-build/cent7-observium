#!/bin/bash
DIR="/srv/observium"

# Check if /var/www empty or not
if [ "$(ls -A $DIR)" ]; then
     echo "Enjoy your Observium ...!"
else
    echo "Copy Observium to webroot ...!"
    mkdir /usr/src/observium/{rrd,logs}
    cp -r /usr/src/observium/* $DIR/
    cd $DIR/ && cp config.php.default config.php && \
    chown -R apache:apache $DIR
fi

# Check configuration
chk_host=`grep localhost $DIR/config.php|awk '{print $3}'`
if [ "$chk_host" == "'localhost';" ]; then
    echo "Configuration has been changed...!"
    cd $DIR/
    sed -i '17i$config['fping'] = "/usr/sbin/fping";' config.php && \
    sed -i "s/'localhost'/'$DB_OBSERVIUM_HOST'/" config.php && \
    sed -i "s/'USERNAME'/'$DB_OBSERVIUM_USER'/" config.php && \
    sed -i "s/'PASSWORD'/'$DB_OBSERVIUM_PASSWORD'/" config.php && \
    sed -i "s/'observium'/'$DB_OBSERVIUM_NAME'/" config.php && \
    exit
fi

