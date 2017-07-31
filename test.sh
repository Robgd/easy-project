#!/usr/bin/env bash

#OSEF=`docker-machine ls -q`
#echo $OSEF

#if `docker-machine ssh dev mount | grep -qi 'Stopped'`
#then
#    echo 'test'
#fi
#
#
#echo 'bla'

#docker-machine start dev
#while [ `docker-machine ls | grep -qi 'Stopped'` ]
#do
#    echo 'wait for dev machine started...'
#    sleep 5
#done

#BASH_PATH=$HOME/.zshrc
#
#echo "export EASY_PROJECT_PATH=\"$HOME/www/\"" >> $BASH_PATH


source ./color.sh

PROJECT_NAME=blog

echo 'start non root'

sudo -s <<EOF
echo "127.0.0.1    $PROJECT_NAME.dev" >> /etc/hosts
EOF