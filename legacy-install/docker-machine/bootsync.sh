#!/usr/bin/env bash

kill 'more /var/run/udhcpc.eth1.pid'
ifconfig eth1 192.168.99.100 netmask 255.255.255.0 broadcast 192.168.99.255 up
#while true; do time rsync -a --delete /opt/robgd/cache/ $PROJECT_PATH/$PROJECT_NAME/var/cache/; sleep 30; done &
