FROM ubuntu:latest
MAINTAINER Robin Godart <godartrobin@gmail.com>

RUN apt-get update && apt-get install -y nginx php7.0-common php7.0-curl php7.0-fpm \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y phpmyadmin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./nginx.conf /etc/nginx/
COPY ./sites-available/phpmyadmin /etc/nginx/sites-available/phpmyadmin

COPY ./config.inc.php /etc/phpmyadmin/config.inc.php
RUN ln -s /etc/nginx/sites-available/phpmyadmin /etc/nginx/sites-enabled/phpmyadmin
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

COPY ./run.sh /root/run.sh
RUN chmod +x /root/*.sh

# Define default command.
CMD ["/root/run.sh"]

EXPOSE 80
EXPOSE 443
