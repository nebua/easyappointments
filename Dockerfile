FROM php:8.1.0-fpm
RUN apt-get update && apt-get install -y nodejs npm
# Set working directory
WORKDIR /var/www/public

# Add docker php ext repo
ADD docker/install-php-extensions /usr/local/bin/


# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mbstring pdo_mysql zip exif pcntl gd memcached \
    bcmath ldap gd pdo pdo_pgsql pgsql pdo_mysql intl opcache

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

#RUN    echo "de_DE.UTF-8 UTF-8\nen_US.UTF-8 UTF-8\nes_ES.UTF-8 UTF-8\nfr_FR.UTF-8 UTF-8\nid_ID.UTF-8 UTF-8\nit_IT.UTF-8 UTF-8\nnl_NL.UTF-8 UTF-8\npl_PL.UTF-8 UTF-8\npt_BR.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8\ntr_TR.UTF-8 UTF-8\nzh_TW.UTF-8 UTF-8\nzh_CN.UTF-8 UTF-8\n\n" > /etc/locale.gen
#RUN    locale-gen

RUN chmod +x /var/www/public/docker/run.sh

EXPOSE 8080
ENTRYPOINT ["/var/www/public/docker/run.sh"]