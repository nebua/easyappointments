#!/bin/sh

cd /var/www

# Deployment steps

npm install && composer install --optimize-autoloader --no-dev
npm start

/usr/bin/supervisord -c /etc/supervisord.conf