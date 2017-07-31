#!/usr/bin/env bash

source ./color.sh

usage="$(basename "$0") - Install project by choosing a framework and a project name

Usage: create-project [options]
       create-project [framework] [project_name]

Options:
    [framwework] [project_name]         Install new project
    -h                                  show this help text

Exemple:
    create-project symfony my_blog
"

while getopts ':h' opt; do
  case "$opt" in
    h) echo "$usage"
       exit
       ;;
   \?)
      echo "Invalid option: -$OPTARG" >&2
      exit
      ;;
  esac
done

if [ -z "$1" ]
  then
    echo "$usage"
    exit
fi

if [ -z "$2" ]
  then
    echoWarn "[project_name] argument is missing"
    exit
fi

FRAMEWORK=$1
PROJECT_NAME=$2


# @info:    do nginx configuration
# @args:    project name
nginxConfig()
{
    docker cp ./docker/nginx/sites-available/nginx-$1-config nginx:/etc/nginx/sites-enabled/${PROJECT_NAME}
    docker exec -t -i nginx sed -i -e "s#{{PROJECT_NAME}}#$PROJECT_NAME#g" /etc/nginx/sites-enabled/${PROJECT_NAME}
    docker exec -t -i nginx service nginx restart
}

addVHost()
{
sudo -s <<EOF
echo "127.0.0.1    $PROJECT_NAME.dev" >> /etc/hosts
EOF
}

installSymfony()
{
    nginxConfig "symfony"

    default=$HOME/www
    read -p "- Enter your website (${YELLOW}$default${COL_RESET}): " PROJECT_PATH
    PROJECT_PATH=${PROJECT_PATH:-$default}

    symfony new $PROJECT_PATH/$PROJECT_NAME

    addVHost
}

installLaravel()
{
    echo 'test'
}

installWordpress()
{
    echo 'test'
}

case $FRAMEWORK in
    "symfony")
        installSymfony
        ;;
    "laravel")
        installLaravel
        ;;
    "wordpress")
        installWordpress
        ;;
    *)
        echoWarn "Only these projects are supported (symfony, laravel, wordpress)"
        ;;
esac