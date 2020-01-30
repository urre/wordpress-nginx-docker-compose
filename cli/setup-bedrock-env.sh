#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'

OVERWRITE=false

ask_for_overwrite () {
    echo -e "${YELLOW}File already exists! Overwrite? [y/n]: ${NC}"
    read QUESTION
    if [[ ${QUESTION} == "y" ]]; then
        OVERWRITE=true
    elif [[ ${QUESTION} == "n" ]]; then
        OVERWRITE=false
    else
        echo -e "${YELLOW}Please answer with 'y' or 'n'! ${NC}"
        ask_for_overwrite
    fi
}

source "../.env"

if [[ -f ../src/.env ]]; then
    ask_for_overwrite
fi

if [[ ${OVERWRITE} == true ]]; then
    echo -e "${BLUE}Generating Bedrock environment file... ${NC}"

    echo "DB_HOST=${DB_HOST}:3306
DB_NAME=${DB_NAME}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_ROOT_PASSWORD}
DB_PREFIX=${DB_TABLE_PREFIX}

WP_ENV=${WP_ENV}
WP_HOME=${WP_HOME}
WP_SITEURL=${WP_SITEURL}

AUTH_KEY='${AUTH_KEY}'
SECURE_AUTH_KEY='${SECURE_AUTH_KEY}'
LOGGED_IN_KEY='${LOGGED_IN_KEY}'
NONCE_KEY='${NONCE_KEY}'
AUTH_SALT='${AUTH_SALT}'
SECURE_AUTH_SALT='${SECURE_AUTH_SALT}'
LOGGED_IN_SALT='${LOGGED_IN_SALT}'
NONCE_SALT='${NONCE_SALT}'
" > ../src/.env

    echo -e "${BLUE}Validating... ${NC}"

    if [[ -f ../src/.env ]]; then
        echo -e "${GREEN}Bedrock .env successfully generated! ${NC}"
        exit 0
    else
        echo -e "${RED}Something went wrong, please try again! ${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}Will not overwrite existing config. Aborting. ${NC}"
    exit 0
fi
