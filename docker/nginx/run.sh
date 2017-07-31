#!/usr/bin/env bash

service nginx start
service php7.0-fpm start

tail -f /dev/null