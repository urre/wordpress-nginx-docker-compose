#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'

CREATE_BACKUP="$1"

source "../.env"

DOMAIN=$(echo "$DOMAIN")

if [[ -f ../nginx/wordpress_ssl.conf && $CREATE_BACKUP != "-nb" ]]; then
    echo -e "${YELLOW}Config already exists! Creating Backup... ${NC}"
    mv ../nginx/wordpress_ssl.conf "../nginx/wordpress_ssl.conf_BAK_$(date +"%Y%m%d_%H%M%S")"
fi

sed "s/myapp\.local/$DOMAIN/g" ../nginx/wordpress_ssl.conf.example > ../nginx/wordpress_ssl.conf

echo -e "${BLUE}Verifying... ${NC}"

if [ -f ../nginx/wordpress_ssl.conf ]; then
    echo -e "${GREEN}New nginx config successfully created! ${NC}"
else
    echo -e "${RED}Something went wrong! Please try again. ${NC}"
fi
