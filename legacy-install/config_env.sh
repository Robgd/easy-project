#!/usr/bin/env bash

# Colors
COL_RESET=$'\e[39;49;00m'
RED=$'\e[31;01m'
GREEN=$'\e[32;01m'
YELLOW=$'\e[33;01m'
BLUE=$'\e[34;01m'
MAGENTA=$'\e[35;01m'
CYAN=$'\e[36;01m'

EASY_PROJECT_DOCKER_PATH=test\/to\/path

echo "${YELLOW}======= Config docker variables ======${COL_RESET}"
rm -f ./docker/docker-compose.yml
cp ./docker/docker-compose.yml.dist ./docker/docker-compose.yml
sed -i -e "s#{{DOCKER_PATH}}#$EASY_PROJECT_DOCKER_PATH#g" docker/docker-compose.yml
echo "${GREEN}======= Done ! =======${COL_RESET}"
