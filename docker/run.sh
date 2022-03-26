#!/bin/sh

cd /var/www/public

# Deployment steps

npm install && composer update && composer install
npm start

/usr/bin/supervisord -c /etc/supervisord.conf