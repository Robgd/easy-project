FROM ubuntu:latest
MAINTAINER Robin Godart <godartrobin@gmail.com>

RUN apt-get update && apt-get install -y \
    curl \
    php7.0-cli \
    php7.0-json \
    php7.0-intl \
    php7.0-mysqlnd \
    php7.0-curl \
    php-apcu \
    php-xdebug \
    checkinstall \
    nodejs \
    libxrender1 \
    libfontconfig1 \
    mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN phpdismod xdebug

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

COPY ./conf.d/30-robgd.ini /etc/php7.0/cli/conf.d/30-robgd.ini

WORKDIR /var/www
