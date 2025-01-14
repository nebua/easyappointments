FROM php:8.1.0-fpm

RUN apt-get install curl

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update && apt-get install -y nodejs
# Set working directory
WORKDIR /var/www/public

# Add docker php ext repo
ADD docker/install-php-extensions /usr/local/bin/


# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions pdo_mysql mysqli zip exif pcntl gd memcached \
    bcmath ldap pdo_pgsql pgsql intl opcache

# Install dependencies https://computingforgeeks.com/how-to-install-php-on-ubuntu-linux-system/
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    git \
    curl \
    lua-zlib-dev \
    libmemcached-dev \
    nginx 


RUN apt-get install libldb-dev libldap2-dev -y

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so

RUN apt-get install -y libpq-dev

#RUN    docker-php-ext-configure ldap --with-libdir=lib/$(gcc -dumpmachine)
#RUN    docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql 
#RUN apt-get install libicu-dev -y

#RUN    docker-php-ext-install -j$(nproc) bcmath ldap gd pdo pdo_pgsql pgsql pdo_mysql intl opcache

#RUN    pecl install memcached-3.2.0RC2

# # Install supervisor
RUN apt-get install -y supervisor

# # Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# # Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# # Copy code to /var/www/public
COPY --chown=www:www-data . /var/www/public

# # add root to www group
RUN chmod -R ug+w /var/www/public/storage

# # Copy nginx/php/supervisor configs
RUN cp docker/supervisor.conf /etc/supervisord.conf
RUN cp docker/php.ini /usr/local/etc/php/conf.d/app.ini
RUN cp docker/nginx.conf /etc/nginx/sites-enabled/default

# # PHP Error Log Files
RUN mkdir /var/log/php
RUN touch /var/log/php/errors.log && chmod 777 /var/log/php/errors.log

RUN chmod +x /var/www/public/docker/generateConfig.sh
RUN chmod +x /var/www/public/docker/run.sh


EXPOSE 8080
ENTRYPOINT ["/var/www/public/docker/run.sh"]