FROM ubuntu:latest
MAINTAINER Robin Godart <godartrobin@gmail.com>

RUN apt-get update && apt-get install -y \
    php-apcu \
    php7.0-cli \
    php7.0-common \
    php7.0-curl \
    php7.0-fpm \
    php7.0-gd \
    php-geoip \
    php7.0-intl \
    php7.0-mcrypt \
    php7.0-mysql \
    php7.0-readline \
    php-xdebug \
    php7.0-xml \
    php7.0-mbstring \
    libxrender1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN phpdismod xdebug

RUN sed -i "s@listen = /run/php/php7.0-fpm.sock@listen = 9000@" /etc/php/7.0/fpm/pool.d/www.conf

WORKDIR /var/www
COPY ./conf.d/30-robgd.ini /etc/php7.0/fpm/conf.d/30-robgd.ini

COPY ./run.sh /root/run.sh
RUN chmod 775 /root/*.sh

CMD ["/root/run.sh"]

EXPOSE 9000
