#!/usr/bin/env bash

default=$HOME/docker
read -p "- Enter the docker path (${YELLOW}$default${COL_RESET}): " DOCKER_PATH
DOCKER_PATH=${DOCKER_PATH:-$default}

default=$HOME/www
read -p "- Enter your website (${YELLOW}$default${COL_RESET}): " PROJECT_PATH
PROJECT_PATH=${PROJECT_PATH:-$default}

echo "${YELLOW}======= Config docker variables ======${COL_RESET}"
rm -f ./docker/docker-compose.yml
cp ./docker/docker-compose.yml.dist ./docker/docker-compose.yml
sed -i -e "s#{{DOCKER_PATH}}#$DOCKER_PATH#g" docker/docker-compose.yml
sed -i -e "s#{{PROJECT_PATH}}#$PROJECT_PATH#g" docker/docker-compose.yml
echo "${GREEN}======= Done ! =======${COL_RESET}"
