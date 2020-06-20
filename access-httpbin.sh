#!/bin/bash

# Bash 脚本 set 命令教程
# http://www.ruanyifeng.com/blog/2017/11/bash-set.html
set -o errexit
# set -o xtrace
set -o nounset
set -o pipefail


# 脚本所在路径作为基础路径
UNAME=$(uname)

BASH_SOURCE_NAME=${BASH_SOURCE[0]}

if [[ "${UNAME}" == "Linux" ]]; then
    SCRIPT_FILE=$(readlink -f "${BASH_SOURCE_NAME}")
fi


if [[ "${UNAME}" == "Darwin" ]]; then
    if [[ $(echo ${BASH_SOURCE_NAME} | awk '/^\//') == ${BASH_SOURCE_NAME} ]]; then
        SCRIPT_FILE=${BASH_SOURCE_NAME}
    else
        SCRIPT_FILE=$PWD/${BASH_SOURCE_NAME}
    fi
fi

export BASE_PATH_DOCKER_COMPOSE=$(dirname "${SCRIPT_FILE}")

# docker-compose 文件
DOCKER_COMPOSE_FILE=${BASE_PATH_DOCKER_COMPOSE}/httpbin-compose.yml


PROJECT_NAME=httpbin


if [[ "$1" == "1" ]]; then
    docker-compose --file "${DOCKER_COMPOSE_FILE}" --project-name "${PROJECT_NAME}" up -d
else
    docker-compose --file "${DOCKER_COMPOSE_FILE}" --project-name "${PROJECT_NAME}" down
fi
