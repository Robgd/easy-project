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

case "$FRAMEWORK" in
    "symfony")
        installSymfony()
        ;;
    "laravel")
        installLaravel
        ;;
    "wordpress")
        installWordpress
        ;;
    *)
        echoWarn 'Only these projects are supported (symfony, laravel, wordpress)'
        ;;
esac

installSymfony()
{


}

# @info:    do nginx configuration
# @args:    project name
nginxConfig()
{
    docker cp ./docker/nginx/sites-available/nginx-project-config nginx:/etc/nginx/site-enabled/${PROJECT_NAME}
    docker exec -t -i nginx sed -i -e "s#{{DOCKER_PATH}}#$EASY_PROJECT_DOCKER_PATH#g" docker/docker-compose.yml
}
