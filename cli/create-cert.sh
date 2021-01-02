#!/bin/bash

set -e

source "../.env"

DOMAIN=$(echo "$DOMAIN")

mkcert "${DOMAIN}"

mkdir -p ../certs

find . -type f -name "*.pem" -exec mv {} ../certs \;
