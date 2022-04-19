#!/bin/sh

cd /var/www/public

# Deployment steps
bash ./docker/generateConfig.sh /var/www/public/config.php

npm install 
composer update
composer install #--optimize-autoloader --no-dev

/usr/bin/supervisord -c /etc/supervisord.conf
