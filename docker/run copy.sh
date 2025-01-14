#!/bin/sh

 # Deployment steps
 bash /usr/share/nginx/html/docker/generateConfig.sh /usr/share/nginx/html/config.php

cd /usr/share/nginx/html
##npm cache clean --force

npm install 

# composer update
 composer install #--optimize-autoloader --no-dev
#npm start

# Update nginx to match worker_processes to no. of cpu's
procs=$(cat /proc/cpuinfo | grep processor | wc -l)
sed -i -e "s/worker_processes  1/worker_processes $procs/" /etc/nginx/nginx.conf

# Always chown webroot for better mounting
chown -Rf nginx:nginx /usr/share/nginx/html

# Start supervisord and services
/usr/local/bin/supervisord -n -c /etc/supervisord.conf
